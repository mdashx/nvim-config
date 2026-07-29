-- Go doc command integration for keywords and packages
local function go_doc_word_under_cursor()
  local word = vim.fn.expand('<cword>')
  if word == '' then
    vim.notify('No word under cursor', vim.log.levels.WARN)
    return
  end

  -- Open vertical split
  vim.cmd('vsplit')

  -- Create a new buffer for output
  vim.cmd('enew')
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'hide'
  vim.opt_local.swapfile = false

  -- Set buffer name
  vim.api.nvim_buf_set_name(0, 'go doc: ' .. word)

  -- Run go doc using vim.system (neovim 0.10+)
  local result = vim.system({ 'go', 'doc', word }, { text = true }):wait()
  local output = result.stdout or 'No documentation found'

  -- Insert output into buffer
  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Set filetype for syntax highlighting
  vim.opt_local.filetype = 'go'

  -- Make buffer read-only
  vim.opt_local.readonly = true
  vim.opt_local.modifiable = false
end

-- Keybinding: <leader>gs for "go spec/source"
vim.keymap.set('n', '<leader>gs', go_doc_word_under_cursor, {
  noremap = true,
  desc = '[G]o [S]pec/doc for word under cursor',
})
