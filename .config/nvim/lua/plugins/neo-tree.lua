return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
    },
  },
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
    },
  },
}
