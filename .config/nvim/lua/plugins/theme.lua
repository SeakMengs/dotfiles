-- Do leader+u+C to test the theme
return {
  { "folke/tokyonight.nvim" },

  -- Configure LazyVim to load theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
