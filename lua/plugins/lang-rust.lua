return {
  { import = "lazyvim.plugins.extras.lang.rust" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          diagnostics = {
            enable = true,
            disabled = { "unresolved-proc-macro" },
            enableExperimental = true,
          },
        },
      },
    },
  },
}
