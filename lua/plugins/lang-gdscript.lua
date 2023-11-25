return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          filetypes = { "gd", "gdscript", "GDScript" },
        },
      },
    },
  },
}
