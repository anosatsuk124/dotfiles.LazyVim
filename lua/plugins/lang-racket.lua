return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        racket_langserver = {
          filetypes = { "racket", "scheme" },
        },
      },
    },
  },
}
