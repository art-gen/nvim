vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
})

require('blink.cmp').setup({
  keymap = { preset = 'default' },   -- <C-y> принять, <C-space> открыть, <C-e> закрыть
  completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  signature = { enabled = true },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
