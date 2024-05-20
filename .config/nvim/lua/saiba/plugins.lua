-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- AI code assistant
  "David-Kunz/gen.nvim",

  -- Autopairs
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  -- Bufferline
  {'akinsho/bufferline.nvim', version = '*', dependencies = {'nvim-tree/nvim-web-devicons'}},

  -- Colorscheme
  'rktjmp/lush.nvim',
  {'saiba-tenpura/pywal-theme.nvim', as = 'pywal-theme'},

  -- Colorizer
  'norcalli/nvim-colorizer.lua',

  -- Extendable Fuzzy Finder
  {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim'}},

  -- Git
  'lewis6991/gitsigns.nvim',

  -- LSP Highlighting
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

  -- Explorer
  {'nvim-tree/nvim-tree.lua', version = '*', lazy = false, dependencies = {'nvim-tree/nvim-web-devicons'}},

  -- Icons
  'nvim-tree/nvim-web-devicons',
  'onsails/lspkind-nvim',

  -- LaTeX
  {'lervag/vimtex', lazy = false},

  -- LSP Support
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},

  -- Statusline
  {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}}
})
