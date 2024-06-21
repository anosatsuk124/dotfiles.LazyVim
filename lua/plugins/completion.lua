return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "onsails/lspkind.nvim",
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = "copilot.lua",
      --   opts = {},
      --   config = function(_, opts)
      --     local copilot_cmp = require("copilot_cmp")
      --     copilot_cmp.setup(opts)
      --     -- attach cmp source whenever copilot attaches
      --     -- fixes lazy-loading issues with the copilot cmp source
      --     require("lazyvim.util").lsp.on_attach(function(client)
      --       if client.name == "copilot" then
      --         copilot_cmp._on_insert_enter({})
      --       end
      --     end)
      --   end,
      -- },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, 1, { name = "codeium" })
      table.insert(opts.formatting, 1, {
        format = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Codeium = "" },
        }),
      })
      -- table.insert(opts.sources, 1, {
      --   name = "copilot",
      --   group_index = 1,
      --   priority = 100,
      -- })
    end,
  },
}
