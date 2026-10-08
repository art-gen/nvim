local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Закрыть буфер" })
map("v", "<", "<gv")
map("v", ">", ">gv")
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Выйти из terminal-mode" })

-- Диагностика (]d / [d уже есть в nvim по умолчанию)
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Диагностика" })
