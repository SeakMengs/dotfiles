-- Override lsp default config
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        phpactor = false,
        intelephense = {
          filetypes = { "php", "blade", "php_only" },
          settings = {
            intelephense = {
              filetypes = { "php", "blade", "php_only" },
              files = {
                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                maxSize = 5000000,
              },
            },
          },
        },
      },
      diagnostics = {
        virtual_text = {
          severity = { min = vim.diagnostic.severity.ERROR }, -- inline only errors
        },
        underline = {
          severity = { min = vim.diagnostic.severity.WARN }, -- underline warn+
        },
        signs = {
          severity = { min = vim.diagnostic.severity.WARN }, -- gutter signs warn+
        },
        float = {
          border = "rounded",
          source = "if_many",
        },
        severity_sort = true,
      },
    },
  },
}
