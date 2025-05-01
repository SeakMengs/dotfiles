return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {},
    config = function(_, opts)
      local chat = require("CopilotChat")

      -- Enable line number override lazyvim config which disable line number
      -- https://www.lazyvim.org/extras/ai/copilot-chat#copilotchatnvim
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
        end,
      })

      chat.setup(opts)
    end,
  },
}
