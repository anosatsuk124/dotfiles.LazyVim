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
    config = {
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
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },

  --  {
  --    "yetone/avante.nvim",
  --    event = "VeryLazy",
  --    lazy = false,
  --    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --    opts = {
  --      system_prompt = function()
  --         local hub = require("mcphub").get_hub_instance()
  --        return hub:get_active_servers_prompt()
  --      end,
  --      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
  --      custom_tools = function()
  --        return {
  --          require("mcphub.extensions.avante").mcp_tool(),
  ---        }
  --      end,
  --
  --      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  --      -- provider = "openai", -- Recommend using Claude
  --      -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
  --      -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
  --      -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
  --      provider = "gemini_2",
  --      vendors = {
  --        gemini_flash = {
  --          __inherited_from = "openai",
  --          api_key_name = "OPENROUTER_KEY",
  --          endpoint = "https://openrouter.ai/api/v1",
  --          model = "google/gemini-2.0-flash-thinking-exp:free",
  --        },
  --        qwen = {
  --          __inherited_from = "openai",
  --          api_key_name = "OPENROUTER_KEY",
  --          endpoint = "https://openrouter.ai/api/v1",
  --          model = "qwen/qwen-2.5-72b-instruct",
  --        },
  --        gemini_2 = {
  --          __inherited_from = "openai",
  --          api_key_name = "OPENROUTER_KEY",
  --          endpoint = "https://openrouter.ai/api/v1",
  --          model = "google/gemini-2.0-flash-001",
  --        },
  --        mistral_soba = {
  --          __inherited_from = "openai",
  --          api_key_name = "OPENROUTER_KEY",
  --          endpoint = "https://openrouter.ai/api/v1",
  --          model = "mistralai/mistral-saba",
  --        },
  --      },
  --
  --      auto_suggestions_provider = "qwen",
  --      ---Specify the special dual_boost mode
  --      ---1. enabled: Whether to enable dual_boost mode. Default to false.
  --      ---2. first_provider: The first provider to generate response. Default to "openai".
  --      ---3. second_provider: The second provider to generate response. Default to "claude".
  --      ---4. prompt: The prompt to generate response based on the two reference outputs.
  --      ---5. timeout: Timeout in milliseconds. Default to 60000.
  --      ---How it works:
  --      --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
  --      ---Note: This is an experimental feature and may not work as expected.
  --      behaviour = {
  --        auto_suggestions = false, -- Experimental stage
  --        auto_set_highlight_group = true,
  --        auto_set_keymaps = true,
  --        auto_apply_diff_after_generation = false,
  --        support_paste_from_clipboard = false,
  --        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
  --      },
  --      mappings = {
  --        --- @class AvanteConflictMappings
  --        diff = {
  --          ours = "co",
  --          theirs = "ct",
  --          all_theirs = "ca",
  --          both = "cb",
  --          cursor = "cc",
  --          next = "]x",
  --          prev = "[x",
  --        },
  --        suggestion = {
  --          accept = "<C-]><C-]>",
  --          next = "<M-]>",
  --          prev = "<M-[>",
  --          dismiss = "<C-[>",
  --        },
  --        jump = {
  --          next = "]]",
  --          prev = "[[",
  --        },
  --        submit = {
  --          normal = "<CR>",
  --          insert = "<C-s>",
  --        },
  --        sidebar = {
  --          apply_all = "A",
  --          apply_cursor = "a",
  --          switch_windows = "<Tab>",
  --          reverse_switch_windows = "<S-Tab>",
  --        },
  --      },
  --      hints = { enabled = true },
  --      windows = {
  --        ---@type "right" | "left" | "top" | "bottom"
  --        position = "right", -- the position of the sidebar
  --        wrap = true, -- similar to vim.o.wrap
  --        width = 30, -- default % based on available width
  --        sidebar_header = {
  --          enabled = true, -- true, false to enable/disable the header
  --          align = "center", -- left, center, right for title
  --          rounded = true,
  --        },
  --        input = {
  --          prefix = "> ",
  --          height = 8, -- Height of the input window in vertical layout
  --        },
  --        edit = {
  --          border = "rounded",
  --          start_insert = true, -- Start insert mode when opening the edit window
  --        },
  --        ask = {
  --          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
  --          start_insert = true, -- Start insert mode when opening the ask window
  --          border = "rounded",
  --          ---@type "ours" | "theirs"
  --          focus_on_apply = "ours", -- which diff to focus after applying
  --        },
  --      },
  --      highlights = {
  --        ---@type AvanteConflictHighlights
  --        diff = {
  --          current = "DiffText",
  --          incoming = "DiffAdd",
  --        },
  --      },
  --      --- @class AvanteConflictUserConfig
  --      diff = {
  --        autojump = true,
  --        ---@type string | fun(): any
  --        list_opener = "copen",
  --        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
  --        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
  --        --- Disable by setting to -1.
  --        override_timeoutlen = 500,
  --      },
  --      suggestion = {
  --        debounce = 600,
  --        throttle = 600,
  --      },
  --    },
  --    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --    build = "make",
  --    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --    dependencies = {
  --
  --      "ravitemer/mcphub.nvim",
  --      "stevearc/dressing.nvim",
  --      "nvim-lua/plenary.nvim",
  --      "MunifTanjim/nui.nvim",
  --      --- The below dependencies are optional,
  --      "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --      "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --      "zbirenbaum/copilot.lua", -- for providers='copilot'
  --      {
  --        -- support for image pasting
  --        "HakonHarnes/img-clip.nvim",
  --        event = "VeryLazy",
  --        opts = {
  --          -- recommended settings
  --          default = {
  --            embed_image_as_base64 = false,
  --            prompt_for_file_name = false,
  --            drag_and_drop = {
  --              insert_mode = true,
  --            },
  --            -- required for Windows users
  --            use_absolute_path = true,
  --          },
  --        },
  --      },
  --      {
  --        -- Make sure to set this up properly if you have lazy=true
  --        "MeanderingProgrammer/render-markdown.nvim",
  --        opts = {
  --          file_types = { "markdown", "Avante" },
  --        },
  --        ft = { "markdown", "Avante" },
  --      },
  --    },
  --  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-]><C-]>",
          prev = "<C-]>[",
          next = "<C-]>]",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
      },
      panel = { enabled = false },
    },
  },
}
