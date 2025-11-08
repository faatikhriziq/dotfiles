-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { silent = true, noremap = true }
-- Tekan jk cepat untuk keluar dari insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode quickly" })

-- Tekan jj juga bisa (sesuai preferensi)
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode quickly" })

-- Untuk keluar dari terminal mode cukup dengan Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("n", "<A-j>", ":m .+1<cr>==", opts)
map("n", "<A-k>", ":m .-2<cr>==", opts)
map("v", "<A-j>", ":m '>+1<cr>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<cr>gv=gv", opts)
