-- lua/plugins/vimtex.lua
return {
  'lervag/vimtex',
  lazy = false,
  ft = 'tex',
  init = function()
    -- Variáveis globais (g.vimtex) devem ser definidas antes de carregar o plugin
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0
  end,
  config = function()
    -- Seus Keymaps
    vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { noremap = true, silent = true, desc = "VimTeX Compile" })
    vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { noremap = true, silent = true, desc = "VimTeX View" })
    vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", { noremap = true, silent = true, desc = "VimTeX Stop" })
  end,
}
