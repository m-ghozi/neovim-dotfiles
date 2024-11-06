-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymaps = vim.keymap
local opts = { noremap = true, silent = true }

-- increment/decrement
keymaps.set("n", "+", "<C-a>")
keymaps.set("n", "-", "<C-x>")

-- delete a word backwards
keymaps.set("n", "dw", "<vb_d>")

-- select all
keymaps.set("n", "<C-a>", "gg<S-v>G")

-- jumplist
keymaps.set("n", "<C-m>", "<C-i>", opts)
