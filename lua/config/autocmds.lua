local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('user', { clear = true })

au('TextYankPost', {
  group = group,
  callback = function() vim.hl.on_yank() end,
})

-- Отступы по языкам
au('FileType', {
  group = group,
  pattern = { 'yaml', 'yaml.ansible', 'json', 'lua', 'ruby', 'sh' },
  callback = function() vim.bo.shiftwidth = 2; vim.bo.tabstop = 2 end,
})
au('FileType', {
  group = group,
  pattern = 'go',
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

-- Вернуть курсор на прошлую позицию
au('BufReadPost', {
  group = group,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
