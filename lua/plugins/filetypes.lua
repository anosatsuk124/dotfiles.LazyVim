vim.filetype.add({
  extension = {
    cs = "csharp",
  },
})

vim.treesitter.language.register("c_sharp", "csharp")

vim.filetype.add({
  extension = {
    gd = "gdscript",
  },
})

return {
  {
    "sheerun/vim-polyglot",
    event = "VeryLazy",
  },
  {
    "vim-scripts/bnf.vim",
    event = "VeryLazy",
  },
}
