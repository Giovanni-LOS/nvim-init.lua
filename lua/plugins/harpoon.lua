-- lua/plugins/harpoon.lua
return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- Keymaps
    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Adicionar Arquivo" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Menu Rápido" })

    vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: Ir para 1" })
    vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: Ir para 2" })
    vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon: Ir para 3" })
    vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon: Ir para 4" })
  end,
}
