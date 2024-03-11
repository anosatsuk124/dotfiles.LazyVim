return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")

      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.swift_format,
      })
    end,
  },
}
