-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap

-- Ctrl+n is set to oil.nvim instead of neotree
-- vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })

keymap("n", "<leader>ae", "<cmd>Copilot enable<cr>", { desc = " Enable (Copilot)" })
keymap("n", "<leader>ad", "<cmd>Copilot disable<cr>", { desc = " Disable (Copilot)" })

-- Save the file with Ctrl+S in insert mode then exit to normal mode
keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- Auto wrap selected text with a tag
function WrapWithTag()
  local tag = vim.fn.input("Enter tag: ")
  if tag ~= "" then
    vim.cmd("normal! `<i<" .. tag .. ">")
    vim.cmd("normal! `>a</" .. tag .. ">")
  end
end
keymap("v", "<M-w>", ":<C-u>lua WrapWithTag()<CR>", { noremap = true, silent = true })
