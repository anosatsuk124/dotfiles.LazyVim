local enabled_langs = {
  -- Defaults:
  "bib",
  "gitcommit",
  "markdown",
  "org",
  "plaintex",
  "rst",
  "rnoweb",
  "tex",
  "pandoc",
  "quarto",
  "rmd",
  -- Additionals:
  "csharp",
  "typescriptreact",
  "typescript",
  "javascriptreact",
  "javascript",
  "lua",
}

return {
  -- { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = enabled_langs,
    dependencies = { "neovim/nvim-lspconfig" },
    -- yes, you can use the opts field, just I'm showing the setup explicitly
    config = function()
      require("ltex_extra").setup({
        -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
        -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
        load_langs = {
          "en-US",
        }, -- en-US as default
        -- boolean : whether to load dictionaries on startup
        init_check = true,
        -- string : relative or absolute path to store dictionaries
        -- e.g. subfolder in the project root or the current working directory: ".ltex"
        -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
        path = vim.fn.expand("$HOME") .. "/.config/Code/User/globalStorage/valentjn.vscode-ltex", -- project root or current working directory
        -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        log_level = "info",
        -- table : configurations of the ltex language server.
        -- Only if you are calling the server from ltex_extra
        filetypes = enabled_langs,
        server_opts = {
          -- capabilities = your_capabilities,
          on_attach = function(client, bufnr)
            -- your on_attach process
          end,
          settings = {
            ltex = {
              enabled = enabled_langs,
              language = "en-US",
              completionEnabled = true,
              additionalRules = {
                motherTongue = "ja-JP",
              },
            },
          },
        },
      })
    end,
  },
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    config = function()
      require("textcase").setup({})
    end,
  },
}
