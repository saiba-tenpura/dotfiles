return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'bashls', 'cssls', 'eslint', 'jsonls', 'lua_ls', 'ts_ls' },
      })
    end
  }
}
