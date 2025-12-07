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

  -- Configuração de Verificação e Sincronização (Delay Asynchronous)
  checker = {
    enabled = true,                      -- Ativa a verificação
    notify = true,                       -- Mostra notificação quando houver atualizações
    check_start = "VeryLazy",            -- Inicia a verificação APÓS o carregamento completo do editor
    sync = {
      enabled = true,
      delay = 3000,                      -- Atraso de 3 segundos (3000ms) antes de tentar sincronizar
    },
  },
})
