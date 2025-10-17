-- lua/plugins/tokyonight.lua
return {
  'folke/tokyonight.nvim',
  lazy = false, -- Precisa ser carregado no início
  priority = 1000, -- Garante que seja o primeiro a carregar
  opts = {
    style = "night",
    terminal_colors = true,
    transparent = false,
  }
}
