-- lua/core/keymaps.lua

-- Keymaps Gerais
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorador de Arquivos" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Substituir com clipboard" })

-- Yank/Paste para o sistema (clipboard do SO)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copiar para o SO" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copiar linha para o SO" })

-- Deletar sem copiar
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Deletar sem yank" })

-- Keymap customizado
vim.keymap.set("n", "<leader>;", "A;<CR>", { noremap = true, silent = true, desc = "Adicionar ; e nova linha" })

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Alternar Undo Tree" })
