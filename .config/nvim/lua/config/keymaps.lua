-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })
vim.keymap.set("n", "<leader>ae", "<cmd>Copilot enable<cr>", { desc = " Enable (Copilot)" })
vim.keymap.set("n", "<leader>ac", "<cmd>Copilot disable<cr>", { desc = " Disable (Copilot)" })
