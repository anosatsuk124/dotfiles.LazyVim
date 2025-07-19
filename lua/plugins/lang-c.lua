return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  --  { import = "lazyvim.plugins.extras.lang.cmake" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },
    },
  },
}
