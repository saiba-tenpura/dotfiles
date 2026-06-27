return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
        languages = { 'vue' },
        configNamespace = 'typescript',
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
