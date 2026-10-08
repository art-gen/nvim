vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Порядок важен: ui первым (тема), lsp до completion
for _, mod in ipairs({
  'ui', 'editor', 'treesitter', 'lsp', 'completion', 'format', 'devops',
}) do
  local ok, err = pcall(require, 'plugins.' .. mod)
  if not ok then
    vim.notify('Модуль plugins.' .. mod .. ': ' .. err, vim.log.levels.ERROR)
  end
end
