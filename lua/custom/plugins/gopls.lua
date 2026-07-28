vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  root_markers = { 'go.mod', '.git' },
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedvariables = true,
      },
    },
  },
})

vim.lsp.enable('gopls')

-- Format on save for Go files
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
  end,
})
