return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
      require("mcphub").setup({
        -- Required options
        port = 3000, -- Port for MCP Hub server
        config = vim.fn.expand("~/.mcpservers.json"), -- Absolute path to config file

        -- Optional options
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    config = function(opts)
      require("user-utils.codecomponion-cmds")
      local codecompanion_utils = require("user-utils.codecompanion-utils")

      local config = {
        opts = {
          language = "Japanese",
        },
        strategies = {
          inline = {
            adapter = nil,
          },
          chat = {
            adapter = "openrouter_gemini_2",
            slash_commands = {},
            tools = {
              ["mcp"] = {
                -- calling it in a function would prevent mcphub from being loaded before it's needed
                callback = function()
                  return require("mcphub.extensions.codecompanion")
                end,
                description = "Call tools and resources from the MCP Servers",
                opts = {
                  requires_approval = true,
                },
              },
            },
          },
        },
        adapters = {
          openrouter_gemini_2 = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "google/gemini-2.0-flash-001",
                },
              },
            })
          end,
          openrouter_deepseek_r1 = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "deepseek/deepseek-r1-distill-llama-70b",
                },
              },
            })
          end,
        },
      }

      config.opts.system_prompt = codecompanion_utils.make_system_prompt(config.opts)

      return require("codecompanion").setup(config)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },
}
