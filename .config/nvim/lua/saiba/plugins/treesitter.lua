return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'bash', 'html', 'scss', 'javascript', 'json', 'lua' },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = { 'latex' },
          additional_vim_regex_highlighting = { 'latex', 'markdown' },
        },
        indent = { enable = true },
      })
    end
  },
}
