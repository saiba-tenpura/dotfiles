local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap leader to space
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode --
-- Move line up/down with alt + j/k
keymap("n", "<A-j>", ":m +1<CR>", opts)
keymap("n", "<A-k>", ":m -2<CR>", opts)

-- Insert Mode --
-- Move line up/down with alt + j/k
keymap("i", "<A-j>", "<ESC>:m +1<CR>gi", opts)
keymap("i", "<A-k>", "<ESC>:m -2<CR>gi", opts)

-- Visual Mode --
-- Move lines up/down with alt + j/k
keymap("v", "<A-j>", ":m '>+1<CR>gvgv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gvgv", opts)

-- Plugins --
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>gf", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>lg", ":Telescope live_grep<CR>", opts)
