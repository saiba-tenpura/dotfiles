local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Remap leader to space
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode --
-- Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrow keys
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move line up/down with alt + j/k
keymap.set("n", "<A-j>", ":m +1<CR>", opts)
keymap.set("n", "<A-k>", ":m -2<CR>", opts)

-- Insert Mode --
-- Move line up/down with alt + j/k
keymap.set("i", "<A-j>", "<ESC>:m +1<CR>gi", opts)
keymap.set("i", "<A-k>", "<ESC>:m -2<CR>gi", opts)

-- Visual Mode --
-- Move lines up/down with alt + j/k
keymap.set("v", "<A-j>", ":m '>+1<CR>gvgv", opts)
keymap.set("v", "<A-k>", ":m '<-2<CR>gvgv", opts)

-- Persist register on paste
keymap.set("v", "p", '"_dP', opts)

-- Plugins --
-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap.set("n", "<leader>gf", ":Telescope git_files<CR>", opts)
keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", opts)
