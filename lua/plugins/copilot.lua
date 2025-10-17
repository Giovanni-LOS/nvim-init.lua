-- lua/plugins/copilot.lua
return {
  'github/copilot.vim', -- Assumindo que você usa a versão vimscript/keymap
  event = "InsertEnter", -- Carrega quando entra no modo de inserção
  config = function()
    -- Seu Keymap
    vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)', { desc = "Copilot: Aceitar Sugestão" })
  end,
}
