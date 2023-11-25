local function configure_filetype()
  -- C#

  vim.filetype.add({
    extension = {
      cs = "csharp",
    },
  })

  vim.treesitter.language.register("c_sharp", "csharp")

  -- GDScript

  vim.filetype.add({
    extension = {
      gd = "GDScript",
    },
  })
end

return {
  {
    "sheerun/vim-polyglot",
    lazy = false,
    config = function(_, _)
      configure_filetype()
    end,
  },
  {
    "vim-scripts/bnf.vim",
    lazy = false,
  },
}
