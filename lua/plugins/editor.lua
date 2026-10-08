vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/echasnovski/mini.pairs",
})

local fzf = require("fzf-lua")
fzf.setup({ "default-title" })

local map = vim.keymap.set
map("n", "<leader>ff", fzf.files, { desc = "Файлы" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "Буферы" })
map("n", "<leader>fh", fzf.helptags, { desc = "Help" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "Недавние" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Диагностика" })
map("n", "<leader>fr", fzf.resume, { desc = "Продолжить поиск" })

require("oil").setup({ view_options = { show_hidden = true } })
map("n", "-", "<cmd>Oil --float<cr>", { desc = "Файловый менеджер" })

require("mini.pairs").setup()
