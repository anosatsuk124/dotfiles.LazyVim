-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local util = require("lazyvim.util")

local map = util.safe_keymap_set

-- Mapping jj-like keys to space

map("i", "jj", "<esc>")
map("i", "jf", "<esc>")

-- Increment/decrement numbers

map("n", "<C-+>", "<C-a>")
map("n", "<C-=>", "<C-a>")
map("n", "<C-->", "<C-a>")

map("n", "<leader>v", ":lua Toggle_venn()<CR>", { desc = "Toggle diagram" })
