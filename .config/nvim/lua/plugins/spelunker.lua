return {
  {
    "kamykn/spelunker.vim",
    init = function()
      vim.opt.spell = false
    end,
    config = function()
      -- Customize highlights to remove background and foreground but keep underline | sp is underline color
      vim.api.nvim_set_hl(0, "SpelunkerSpellBad", { undercurl = true, sp = "#415270", bg = "none", fg = "none" })
      vim.api.nvim_set_hl(
        0,
        "SpelunkerComplexOrCompoundWord",
        { undercurl = true, sp = "#415270", bg = "none", fg = "none" }
      )
    end,
  },
}
