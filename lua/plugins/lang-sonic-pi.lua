return {
  {
    "magicmonty/sonicpi.nvim",
    ft = { "sonicpi", "pi" },
    config = function()
      local sonicpi = require("sonicpi")
      local remote = require("sonicpi.remote")
      local lspconfig = require("lspconfig")
      local cmp = require("cmp")

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*.sonicpi", "*.pi" },
        callback = function()
          local timer = vim.uv.new_timer()
          timer:start(800, 0, function()
            remote.startServer()
          end)
        end,
      })

      vim.api.nvim_create_autocmd({ "BufLeave" }, {
        pattern = { "*.sonicpi", "*.pi" },
        callback = function()
          remote.stop()
        end,
      })

      local replay = function()
        remote.stop()
        remote.run_current_buffer()
      end

      sonicpi.setup({
        server_dir = "/Applications/Sonic Pi.app/Contents/Resources/server", -- It will try to find the SonicPi server
        lsp_diagnostics = true, -- enable LSP diagnostics
        mappings = {
          { "n", "<leader>s", remote.stop, default_mapping_opts },
          { "i", "<M-s>", remote.stop, default_mapping_opts },
          { "n", "<leader>r", replay, default_mapping_opts },
          { "i", "<M-r>", replay, default_mapping_opts },
        },
      })

      lspconfig.solargraph.setup({
        filetypes = { "ruby", "sonicpi", "pi" },
        on_init = function(client)
          sonicpi.lsp_on_init(client, { server_dir = "/Applications/Sonic Pi.app/Contents/Resources/server" })
        end,
      })

      cmp.setup({
        sources = {
          { name = "sonicpi" },
        },
      })
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "kyazdani42/nvim-web-devicons",
      "neovim/nvim-lspconfig",
    },
  },
}
