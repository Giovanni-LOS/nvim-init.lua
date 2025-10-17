-- lua/config/lazy.lua

-- 1. BOOTSTRAP: Garante que o lazy.nvim esteja instalado
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. SETUP: Configura e carrega todos os plugins
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },

  -- Configurações Globais do lazy.nvim
  install = { colorscheme = { "tokyonight-night" } },
  checker = { enabled = true },
})

-- 3. AUTOCOMANDO: Auto-update lazy.nvim ao abrir o Vim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("lazy").update({ show = false })
  end,
})

