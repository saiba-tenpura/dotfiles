return {
  {
    'saiba-tenpura/pywal-theme.nvim',
    name = 'pywal-theme',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.cmd.colorscheme('pywal-theme')
    end
  },
}
