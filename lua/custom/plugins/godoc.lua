-- Godoc.nvim setup (plugin is in opt, needs to be packed)
vim.cmd.packadd('godoc.nvim')
local ok, godoc = pcall(require, 'godoc')
if ok then
  godoc.setup {}

  -- Search godoc for current word under cursor
  local function godoc_word_under_cursor()
    local word = vim.fn.expand('<cword>')
    if word == '' then
      vim.cmd('GoDoc')
    else
      vim.cmd('GoDoc ' .. word)
    end
  end

  vim.keymap.set('n', '<leader>go', '<cmd>GoDoc<cr>', { noremap = true, desc = '[G]o [D]oc search' })
  vim.keymap.set('n', '<leader>gO', godoc_word_under_cursor, { noremap = true, desc = '[G]o [D]oc for word under cursor' })
else
  vim.notify('godoc.nvim failed to load', vim.log.levels.WARN)
end
