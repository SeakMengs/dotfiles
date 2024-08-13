-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable copilot by default, use ":Copilot enable" to enable when needed
vim.cmd(":Copilot disable")
