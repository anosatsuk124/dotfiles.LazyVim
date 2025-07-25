-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = true

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.relativenumber = false
opt.number = true
opt.spell = false
opt.spelllang = { "en", "cjk" }
opt.wrap = true
opt.undodir = { vim.fn.expand("$HOME/.cache/neovim/undo") }
opt.undofile = true
opt.signcolumn = "auto"

opt.exrc = true

-- if vim.env.SSH_CONNECTION ~= nil then
--   vim.g.clipboard = {
--     name = "xsel-ssh",
--     copy = {
--       ["+"] = "xsel -i -b",
--       ["*"] = "xsel -i -b",
--     },
--     paste = {
--       ["+"] = "xsel -o -b",
--       ["*"] = "xsel -o -b",
--     },
--     cache_enable = 0,
--   }
-- end
vim.opt.clipboard = "unnamed,unnamedplus"

-- vim.g.minipairs_disable = true
vim.g.lazyvim_picker = "snacks"

-- HACK: Disable lazyvim's check_order
vim.g.lazyvim_check_order = false

require("config.filetypes")
