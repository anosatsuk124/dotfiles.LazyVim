local FUNCS = {}

local VARS = require("user-utils.vars")

--- Load plugins from a directory
--- @param dir_name string
--- `dir_name` must be **the name of a directory** relative to `require("user-utils.vars").plugins_dir`
--- @return table
FUNCS.load_dirplugins = function(dir_name)
  local plugins = {}

  local path = VARS.plugins_dir_absolute .. "/" .. dir_name
  local lua_path = VARS.plugins_lua_path .. "/" .. dir_name

  for file, type in vim.fs.dir(path) do
    if type == "file" and file:match("%.lua$") then
      local file_name = file:match("(.*)%.lua$")

      local plugin = require(lua_path .. "/" .. file_name)

      if plugin then
        vim.list_extend(plugins, plugin)
      end
    end
  end

  return plugins
end

return FUNCS
