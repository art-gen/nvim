-- Хук нужно объявить ДО vim.pack.add
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == 'nvim-treesitter' and d.kind ~= 'delete' then
      if not d.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

require('nvim-treesitter').install({
  'python', 'go', 'gomod', 'gosum', 'gowork',
  'yaml', 'ruby',            -- ruby нужен для Vagrantfile
  'lua', 'vim', 'vimdoc', 'bash', 'json', 'toml',
  'dockerfile', 'markdown', 'markdown_inline', 'regex', 'diff',
})

-- ansible-файлы подсвечиваем парсером yaml
vim.treesitter.language.register('yaml', 'yaml.ansible')

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
})
