return {
  {
    "jiriks74/presence.nvim",
    -- lazy = false,
    event = "UIEnter",
    opts = function(_, opts)
      local text_api = require("textcase").api

      opts.editing_text = function(_filename)
        return "Editing a(n) **" .. text_api.to_constant_case(vim.o.filetype) .. "** file?"
      end
      opts.file_explorer_text = function(_filename)
        return "Exploring a(n) **" .. text_api.to_constant_case(vim.o.filetype) .. "** file?"
      end

      opts.git_commit_text = "Committing changes" -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      opts.plugin_manager_text = "Managing plugins" -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      opts.reading_text = function(_filename)
        return "Reading a(n) **" .. text_api.to_constant_case(vim.o.filetype) .. "** file?"
      end

      opts.workspace_text = "Working on ??" -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      opts.line_number_text = ""

      opts.log_level = "warn"
    end,
  },
}
