-- init.lua
-- 1. Carrega as configurações de opções
require('core.options')

-- 2. Carrega atalhos e ações programadas
require('core.keymaps')
require('core.autocmds')

-- 3. Inicializa o package manager
require('config.lazy')
