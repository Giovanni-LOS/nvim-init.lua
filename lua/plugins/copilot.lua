return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true, -- começa a sugerir enquanto você digita
        debounce = 75,
        keymap = {
          accept = "<Tab>",       -- aceita TUDO (se quiser)
          accept_word = "<C-W>",  -- aceita SÓ a próxima palavra
          accept_line = "<C-L>",  -- aceita a próxima linha
          next = "<M-]>",         -- sugestão seguinte
          prev = "<M-[>",         -- sugestão anterior
          dismiss = "<C-]>",      -- descarta sugestão atual
        },
      },
      panel = {
        enabled = false, -- pode ligar se quiser um painel lateral de sugestões
      },
      filetypes = {
        -- habilita/desabilita por linguagem
        markdown = true,
        help = false,
        gitcommit = true,
      },
    })
  end,
}
