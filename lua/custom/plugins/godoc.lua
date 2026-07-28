return {
  'fredrikaverpil/godoc.nvim',
  ft = 'go',
  keys = {
    { '<leader>go', '<cmd>Godoc<cr>', desc = '[G]o [O]doc search' },
  },
  config = function()
    require('godoc').setup {}
  end,
}
