-- lua/core/options.lua

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Numeração
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentação
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Outras Opções
vim.opt.mouse = ""
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"

-- Desativar as setas nos modos
local function disable_arrows(mode)
  vim.api.nvim_set_keymap(mode, '<Up>', '<Nop>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap(mode, '<Down>', '<Nop>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap(mode, '<Left>', '<Nop>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap(mode, '<Right>', '<Nop>', { noremap = true, silent = true })
end

disable_arrows('n')
disable_arrows('i')
disable_arrows('v')
