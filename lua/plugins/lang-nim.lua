return {
  -- {
  --   "alaviss/nim.nvim",
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nim_langserver = {
          cmd = { "/home/anosatsuk124/.nimble/bin/nimlangserver" },
        },
        -- nimlsp = {
        --   cmd = { "/home/anosatsuk124/.nimble/bin/nimlsp" },
        -- },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.debug = true

      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.nimpretty,
      })
    end,
  },
}
