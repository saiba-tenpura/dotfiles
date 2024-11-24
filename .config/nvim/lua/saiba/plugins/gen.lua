return {
  {
    "David-Kunz/gen.nvim",
    config = function()
      require('gen').setup({
        model = 'llama3.2-vision',
        display_mode = 'split',
      })

      vim.keymap.set({'n', 'v'}, '<leader>]', ':Gen<CR>')
    end
  }
}

