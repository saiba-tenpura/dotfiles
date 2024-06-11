return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        offsets = {
          {
            filetype = 'NvimTree',
            highlight = 'NvimTreeNormal',
            padding = 1,
            text = '',
          },
        },
      },
    },
  },
}
