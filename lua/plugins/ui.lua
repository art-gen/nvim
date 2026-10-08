vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	integrations = {
		gitsigns = true,
		treesitter = true,
		which_key = true,
		blink_cmp = true,
		fzf = true,
		mason = true,
	},
})
vim.cmd.colorscheme("catppuccin")

require("lualine").setup({
	options = {
		theme = "catppuccin",
		globalstatus = true,
		section_separators = "",
		component_separators = "│",
	},
})

require("gitsigns").setup()

local wk = require("which-key")
wk.setup({ preset = "modern" })
wk.add({
	{ "<leader>f", group = "Найти" },
	{ "<leader>c", group = "Код" },
	{ "<leader>v", group = "Vagrant" },
	{ "<leader>a", group = "Ansible" },
})
