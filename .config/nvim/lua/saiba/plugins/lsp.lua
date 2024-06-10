return {
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({buffer = bufnr})
    end)

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = { 'bashls', 'cssls', 'eslint', 'jsonls', 'lua_ls', 'tsserver', 'volar' }
    })

    require('lspconfig').lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          }
        }
      }
    })
    lsp_zero.setup()

    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format(),
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
      }
    })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set({ "n", "v" }, '<leader>ca', vim.lsp.buf.code_action)
  end
}