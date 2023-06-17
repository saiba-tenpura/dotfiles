local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap leader to space
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode --
-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ':bnext<CR>', opts)
keymap("n", "<S-h>", ':bprevious<CR>', opts)

-- Resize with arrow keys
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

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

-- Persist register on paste
keymap("v", "p", '"_dP', opts)

-- Plugins --
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>gf", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>lg", ":Telescope live_grep<CR>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
