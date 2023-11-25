-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local util = require("lazyvim.util")

local map = util.safe_keymap_set

map("i", "jj", "<esc>")
map("i", "jf", "<esc>")

map("n", "<leader>v", ":lua Toggle_venn()<CR>", { desc = "Toggle diagram" })
