vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
  formatters_by_ft = {
    python = { 'ruff_organize_imports', 'ruff_format' },
    go = { 'goimports', 'gofumpt' },
    lua = { 'stylua' },
  },
  format_on_save = { timeout_ms = 1500, lsp_format = 'fallback' },
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format({ lsp_format = 'fallback' })
end, { desc = 'Форматировать' })
