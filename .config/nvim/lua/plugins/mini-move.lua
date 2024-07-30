local options = {
  {
    "echasnovski/mini.move",
    lazy = false,
    config = function()
      require("mini.move").setup {
        mappings = {
          left = "<M-left>",
          right = "<M-right>",
          down = "<M-down>",
          up = "<M-up>",

          line_left = "<M-left>",
          line_right = "<M-right>",
          line_down = "<M-down>",
          line_up = "<M-up>",
        },
      }
    end,
  },
}

return options