-- Do leader+u+C to test the theme
return {
  -- Configure LazyVim to load theme
  {
    "sainnhe/everforest",
    config = function()
      -- " Set contrast.
      -- " This configuration option should be placed before `colorscheme everforest`.
      -- " Available values: 'hard', 'medium'(default), 'soft'
      vim.g.everforest_background = "hard"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-night",
      colorscheme = "everforest",
    },
  },
}
