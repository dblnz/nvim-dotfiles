return {
	-- add more treesitter parsers
	"nvim-treesitter/nvim-treesitter",
	opts = {
		indent = { enable = true },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "org" },
		},
		folds = { enable = true },
		ensure_installed = {
			"bash",
			"git_config",
			"gitcommit",
			"git_rebase",
			"gitignore",
			"gitattributes",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"rust",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
	},
}
