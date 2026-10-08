vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig", -- готовые конфиги серверов (lsp/*.lua)
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

-- Диагностика
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { current_line = true },
	float = { border = "rounded", source = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- ── Настройки серверов ────────────────────────────────────────────
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			analyses = { unusedparameter = true, unusedwrite = true, nilness = true },
			hints = {
				parameterNames = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- импорты делает ruff
			analysis = { typeCheckingMode = "standard" },
		},
	},
})

vim.lsp.config("ansiblels", {
	settings = {
		ansible = {
			python = { interpreterPath = "python3" },
			validation = { enabled = true, lint = { enabled = true, path = "ansible-lint" } },
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
			diagnostics = { globals = { "vim" } },
		},
	},
})

-- ── Mason ─────────────────────────────────────────────────────────
require("mason").setup()

-- mason-lspconfig v2 сам вызывает vim.lsp.enable() для установленных серверов
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"basedpyright",
		"ruff",
		"ansiblels",
		"yamlls",
		"bashls",
		"jsonls",
		"lua_ls",
	},
})

-- Утилиты (форматтеры, линтеры)
require("mason-tool-installer").setup({
	ensure_installed = { "ansible-lint", "gofumpt", "goimports", "stylua" },
})

-- ── Поведение при подключении клиента ─────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		-- Уже есть из коробки: grn rename, gra code action, grr references,
		-- gri implementation, grt type definition, gO symbols, K hover
		map("gd", vim.lsp.buf.definition, "Перейти к определению")
		map("gD", vim.lsp.buf.declaration, "Перейти к объявлению")

		if client and client:supports_method("textDocument/inlayHint") then
			map("<leader>ch", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, "Inlay hints")
		end

		-- hover отдаём basedpyright
		if client and client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})
