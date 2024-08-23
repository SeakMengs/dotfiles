local function max_height()
  local height = vim.fn.winheight(0)
  if height >= 40 then
    return 30
  elseif height >= 30 then
    return 20
  else
    return 10
  end
end

return {
  -- Disable neo-tree and use oil.nvim instead, simple and fast
  { "nvim-neo-tree/neo-tree.nvim", enabled = true },
  {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    -- commit = "18272aba9d00a3176a5443d50dbb4464acc167bd",
    opts = {
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
      delete_to_trash = true,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          local ignore_folders = { "node_modules", "dist", "build", "coverage", "__pycache__" }
          return vim.startswith(name, ".") or vim.tbl_contains(ignore_folders, name)
        end,
      },
      win_options = {
        wrap = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        padding = 2,
        max_width = 120,
        max_height = max_height(),
        border = "rounded",
        win_options = {
          winblend = 0,
          wrap = true,
        },
      },
      -- Custom Keymap
      keymaps = {
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.close",
        ["<C-y>"] = "actions.copy_entry_path",
      },
    },
    -- Use g? to see default key mappings
    keys = {
      {
        "<C-n>",
        function()
          local oil = require("oil")
          oil.toggle_float()

          -- Wait until oil has opened, for a maximum of 1 second.
          vim.wait(1000, function()
            return oil.get_cursor_entry() ~= nil
          end)
          if oil.get_cursor_entry() then
            oil.open_preview()
          end
        end,
        desc = "Open file explorer (Oil)",
      },
    },
  },
}
