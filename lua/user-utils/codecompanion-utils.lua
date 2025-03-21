local M = {}

M.make_system_prompt = function(args)
  local system_prompt = require("codecompanion.config").config.opts.system_prompt(args)

  return function(_)
    -- Get the content of `.cursorrules` file in the project root
    local cursor_rules = vim.fn.readfile(vim.fn.getcwd() .. "/.cursorrules")
    -- If the file exists, append the content to the system prompt
    -- Otherwise, return the default system prompt
    if #cursor_rules > 0 then
      local rule = table.concat(cursor_rules, "\n")
      local rule_prefix =
        "The following rules are specific to this project. In the event of any conflict with the default rules, please prioritize the rules outlined below. \n\n"
      local result = system_prompt .. "\n\n" .. rule_prefix .. "Rules:\n" .. rule
      return result
    else
      return system_prompt
    end
  end
end

return M
