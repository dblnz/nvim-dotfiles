return {
	-- add any tools you want to have installed below
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				-- LSP servers only (formatters/linters are handled by mason-tool-installer below)
				"cssls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"tailwindcss",
				"ts_ls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		})
	end,
}
