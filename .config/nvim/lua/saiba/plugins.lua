-- Install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

-- Reload Neovim on plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Autopairs
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- Bufferline
  use {
    'akinsho/bufferline.nvim', tag = '*',
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- Colorscheme
  use 'rktjmp/lush.nvim'
  use { 'git@github.com:saiba-tenpura/pywal_theme.nvim.git', as = 'pywal_theme' }

  -- Colorizer
  use 'norcalli/nvim-colorizer.lua'

  -- Extendable fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = {{'nvim-lua/plenary.nvim'}}
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {{'nvim-tree/nvim-web-devicons', opt = true}}
  }

  -- Icons
  use 'nvim-tree/nvim-web-devicons'
  use 'onsails/lspkind-nvim'

  -- LSP Support
  use {
    'VonHeikemen/lsp-zero.nvim', branch = 'v2.x',
    requires = {
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  }

  -- Miscellanous
  use 'mbbill/undotree'

  -- Automatically setup configuration after cloning packer
  if packer_bootstrap then
    require('packer').sync()
  end
end)
