-- lua/core/autocmds.lua

-- 1. Aplicar Colorscheme e Highlights (ao iniciar o Vim)
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup('CoreVimEnter', { clear = true }),
  callback = function()
    -- Garante que o colorscheme seja aplicado por último
    vim.cmd("colorscheme tokyonight-night")

    -- Configuração de cor da linha de número
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#00FFFF' })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ffffff' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ffffff' })
  end,
})

-- 2. Abrir imagens e PDFs com xdg-open (antes de ler o buffer)
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup('MediaOpener', { clear = true }),
  pattern = {"*.pdf", "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp"},
  callback = function()
    local file = vim.fn.expand("%:p")
    if vim.fn.filereadable(file) == 1 then
      vim.fn.jobstart({ "xdg-open", file }, { detach = true })
      vim.schedule(function()
        vim.cmd("bd!")
      end)
    end
  end,
  desc = "Abrir Mídias Externamente"
})
