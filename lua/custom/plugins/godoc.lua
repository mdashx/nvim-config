-- Godoc.nvim setup (plugin is in opt, needs to be packed)
vim.cmd.packadd('godoc.nvim')
local ok, godoc = pcall(require, 'godoc')
if ok then
  godoc.setup {}
  vim.keymap.set('n', '<leader>go', '<cmd>GoDoc<cr>', { noremap = true, desc = '[G]o [D]oc search' })
else
  vim.notify('godoc.nvim failed to load', vim.log.levels.WARN)
end
