-- Search snippets via Telescope grep
local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sN', function()
  builtin.live_grep {
    search_dirs = {
      vim.fn.stdpath('data') .. '/site/pack/core/opt/friendly-snippets/snippets',
    },
    prompt_title = 'Search Snippets',
  }
end, { desc = '[S]earch sNippets (friendly-snippets)' })
