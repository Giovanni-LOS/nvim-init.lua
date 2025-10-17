-- lua/plugins/vim-tmux-navigator.lua
return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  config = function()
    -- Mapeamentos para Neovim (dentro dos splits)
    vim.keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { silent = true, desc = "TMUX/Neovim Left" })
    vim.keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { silent = true, desc = "TMUX/Neovim Down" })
    vim.keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { silent = true, desc = "TMUX/Neovim Up" })
    vim.keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { silent = true, desc = "TMUX/Neovim Right" })
    vim.keymap.set('n', '<C-\\>', '<Cmd>TmuxNavigatePrevious<CR>', { silent = true, desc = "TMUX/Neovim Previous" })
  end,
}
