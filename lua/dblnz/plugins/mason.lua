return {
	-- 1. Mason — must load early, not lazily
	{
		"mason-org/mason.nvim",
		lazy = false,
		priority = 100,
		opts = {},
	},
	-- 2. nvim-lspconfig — provided by lsp.lua
	-- 3. mason-lspconfig — bridges Mason and LSP config names
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
		},
	},
	-- 4. mason-tool-installer — ensures formatters/linters are installed (deferred)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua_ls",
				"cssls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"rust_analyzer",
				"pyright",
				"tailwindcss",
				"ts_ls",
				-- Formatters/linters
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},
}
