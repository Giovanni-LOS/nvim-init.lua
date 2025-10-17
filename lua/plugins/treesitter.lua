-- lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', 
  },
  opts = {
    ensure_installed = { "python", "cpp", "go", "c", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    modules = {},
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
