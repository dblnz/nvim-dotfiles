return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Telescope",
	keys = {
		-- File finding
		{ "<leader><leader>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
		-- Custom bindings
		{ "<C-f>f", function() require("telescope.builtin").find_files() end, desc = "Find files", mode = { "n" } },
		{ "<C-f>g", function() require("telescope.builtin").git_files() end, desc = "Find git files", mode = { "n" } },
		{ "<C-f>s", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Search for string", mode = { "n" } },
		{ "<C-f>w", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") }) end, desc = "Search word under cursor", mode = { "n" } },
		{ "<C-f>W", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") }) end, desc = "Search WORD under cursor", mode = { "n" } },
		-- Buffers and help
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
	},
	opts = {
		defaults = {
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
		},
	},
}
