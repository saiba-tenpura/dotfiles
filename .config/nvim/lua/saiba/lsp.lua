local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
  'bashls',
  'eslint',
  'jsonls',
  'lua_ls',
  'tsserver',
  'volar',
})

lsp.on_attach(function(client, bufnr)
  local keymap = vim.keymap
  local opts = {buffer = bufnr, noremap = true}
  keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  keymap.set({"n", "v"}, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

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
lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')
cmp.setup({
  formatting = {
    format = lspkind.cmp_format(),
  },
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  })
})
