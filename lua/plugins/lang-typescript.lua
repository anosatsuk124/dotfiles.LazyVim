local lspconfig = require("lspconfig")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          init_options = {
            lint = true,
            unstable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        },
        tsserver = {
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        },
        vtsls = {
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        },
      },
    },
  },
}
