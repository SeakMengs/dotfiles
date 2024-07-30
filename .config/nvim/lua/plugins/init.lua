return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  -- Ensure that the languages server is installed on every fresh computer
  -- Any languages intellisense that we want, find the lsp name and add it to ensure_installed
  -- If add any changes, update /lua/configs/lspconfig.lua and add lsp to `servers`
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettierd",
        "gopls",
        "typescript-language-server",
        "tailwindcss-language-server",
      },
    },
  },
  -- Syntax highlight for languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "vimdoc",
        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "go",
      },
    },
  },
}
