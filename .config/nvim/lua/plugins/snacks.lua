-- Credit: https://www.reddit.com/r/neovim/comments/1kbqsdc/snacks_explorer_preview_to_the_right/
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      layout = {
        -- This use telescope layout which puts search bar at the bottom
        preset = "telescope",
      },
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            { preview = true },
            layout = {
              box = "horizontal", -- arrange horizontally (list left, preview right)
              width = 0.9,
              height = 0.8,
              {
                box = "vertical",
                border = "rounded",
                title = "{source} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", border = "rounded", width = 0.7, title = "{preview}" },
            },
          },
        },
      },
    },
  },
}
