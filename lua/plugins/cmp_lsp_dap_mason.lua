-- lua/plugins/cmp_lsp_dap_mason.lua (Recomendado nomear como "lsp_cmp_dap.lua")

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Mason e LSP
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Autocompletar
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    -- DAP
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    -- 1. Setup Snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    local cmp = require('cmp')
    local dap = require('dap')
    local dapui = require('dapui')
    local lspconfig = require('lspconfig')

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- 2. Setup CMP (Completamento)
    cmp.setup({
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = "copilot" },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer', keyword_length = 3 },
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })

    -- 3. Setup Mason
    require('mason').setup({})

    -- 4. Setup Mason DAP
    require('mason-nvim-dap').setup({
      ensure_installed = { 'cppdbg', 'pyright', 'texlab' },
      automatic_installation = true,
      handlers = {},
    })

    -- 5. Setup Mason LSPconfig (e LSP)
        local lsp_servers = { 'clangd', 'jdtls', 'pyright', 'lua_ls', 'emmet_ls' }

    require('mason-lspconfig').setup({
      ensure_installed = lsp_servers,
      automatic_installation = true,
      automatic_enable = true,
      handlers = {
        -- Configuração padrão
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
          })
        end,
        -- Configuração específica para pyright
        ['pyright'] = function()
          lspconfig.pyright.setup({
            capabilities = lsp_capabilities,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = 'basic',
                  autoImportCompletions = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,
        -- Configuração específica para lua_ls
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = { library = { vim.env.VIMRUNTIME } },
              },
            },
          })
        end,
        -- Configuração específica para emmet_ls
        ['emmet_ls'] = function()
            require('lspconfig').emmet_ls.setup({
                capabilities = lsp_capabilities,
                filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact', 'haml', 'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss', 'hbs', 'handlebars' },
            })
        end,
      },
    })

    -- 6. Setup DAP (Debug) e DAP-UI
    dap.set_log_level('DEBUG')
    vim.fn.writefile({}, vim.fn.stdpath('data') .. '/dap.log')
    dapui.setup()

    -- Configuração cppdbg
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        console = 'integratedTerminal',
        setupCommands = {
          { text = '-enable-pretty-printing', description = 'enable pretty printing', ignoreFailures = false },
          { text = 'skip -gfi std::', description = 'Skip C++ standard library frames', ignoreFailures = false },
          { text = 'skip -gfi __gnu_cxx::', description = 'Skip GNU C++ internal frames', ignoreFailures = false },
        },
      },
    }

    -- 7. Keymaps e Listeners (LSP e DAP)
    -- Keymaps LSP (Autocmd LspAttach)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
      end,
    })
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "LSP Code Action" })

    -- Keymaps DAP
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
    vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP: Continue/Start" })
    vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DAP: Step Back" })
    vim.keymap.set("n", "<F12>", dap.restart, { desc = "DAP: Restart" })

    -- Listeners DAP-UI
    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close
  end,
}
