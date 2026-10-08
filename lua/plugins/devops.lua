vim.g.ansible_unindent_after_newline = 1
vim.g.ansible_extra_keywords_highlight = 1
vim.pack.add({ "https://github.com/pearofducks/ansible-vim" })

-- ── Хелперы ───────────────────────────────────────────────────────
local function root(markers)
	return vim.fs.root(0, markers) or vim.uv.cwd()
end

local function run(cmd, cwd)
	vim.cmd("botright 15new")
	vim.fn.jobstart(cmd, { term = true, cwd = cwd })
	vim.cmd.startinsert()
end

-- ── Vagrant ───────────────────────────────────────────────────────
local vagrant_sub = {
	"up",
	"halt",
	"reload",
	"provision",
	"destroy",
	"ssh",
	"status",
	"validate",
	"global-status",
	"box",
}
vim.api.nvim_create_user_command("Vagrant", function(o)
	run(vim.list_extend({ "vagrant" }, o.fargs), root({ "Vagrantfile" }))
end, {
	nargs = "+",
	complete = function()
		return vagrant_sub
	end,
})

-- ── Ansible ───────────────────────────────────────────────────────
local function ansible(cmd_prefix, extra)
	local file = vim.fn.expand("%:p")
	local cmd = vim.list_extend(vim.deepcopy(cmd_prefix), { file })
	run(vim.list_extend(cmd, extra or {}), root({ "ansible.cfg", ".git" }))
end

vim.api.nvim_create_user_command("AnsiblePlay", function(o)
	ansible({ "ansible-playbook" }, o.fargs)
end, { nargs = "*" })
vim.api.nvim_create_user_command("AnsibleSyntax", function()
	ansible({ "ansible-playbook", "--syntax-check" })
end, {})
vim.api.nvim_create_user_command("AnsibleLint", function()
	ansible({ "ansible-lint" })
end, {})

-- ── Кейбинды ──────────────────────────────────────────────────────
local map = vim.keymap.set
map("n", "<leader>vu", "<cmd>Vagrant up<cr>", { desc = "vagrant up" })
map("n", "<leader>vp", "<cmd>Vagrant provision<cr>", { desc = "vagrant provision" })
map("n", "<leader>vs", "<cmd>Vagrant ssh<cr>", { desc = "vagrant ssh" })
map("n", "<leader>vh", "<cmd>Vagrant halt<cr>", { desc = "vagrant halt" })
map("n", "<leader>vt", "<cmd>Vagrant status<cr>", { desc = "vagrant status" })

map("n", "<leader>ap", "<cmd>AnsiblePlay<cr>", { desc = "ansible-playbook (файл)" })
map("n", "<leader>as", "<cmd>AnsibleSyntax<cr>", { desc = "syntax-check" })
map("n", "<leader>al", "<cmd>AnsibleLint<cr>", { desc = "ansible-lint" })
