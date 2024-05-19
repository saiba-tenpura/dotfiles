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
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')
cmp.setup({
  formatting = {
    format = lspkind.cmp_format(),
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }
})
