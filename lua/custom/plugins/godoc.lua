-- Godoc.nvim setup (plugin is loaded via vim.pack in init.lua)
local ok, godoc = pcall(require, 'godoc')
if ok then
  godoc.setup {}
  vim.keymap.set('n', '<leader>go', '<cmd>Godoc<cr>', { noremap = true, desc = '[G]o [O]doc search' })
end
