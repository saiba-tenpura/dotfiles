return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
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
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = bufnr})
        vim.keymap.set({ "n", "v" }, '<leader>ca', vim.lsp.buf.code_action, {buffer = bufnr})
      end)

      require('mason-lspconfig').setup({
        ensure_installed = { 'bashls', 'cssls', 'eslint', 'jsonls', 'lua_ls', 'ts_ls', 'volar' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,

          volar = function()
            require('lspconfig').volar.setup({
              init_options = {
                vue = {
                  hybridMode = false,
                },
              },
              filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })
          end
        }
      })
    end
  }
}
