return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "mlaursen/vim-react-snippets",
    },
    opts = function()
      require("vim-react-snippets").lazy_load()
    end,
  },
}
