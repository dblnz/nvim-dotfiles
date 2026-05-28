return {
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gblame" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
			{ "<leader>gl", "<cmd>Git log --oneline<cr>", desc = "Git log" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", function()
				local lib = require("diffview.lib")
				if lib.get_current_view() then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewOpen")
				end
			end, desc = "Diffview toggle" },
			{ "<leader>gD", function()
				local lib = require("diffview.lib")
				if lib.get_current_view() then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewFileHistory %")
				end
			end, desc = "File history toggle" },
		},
		opts = {
			keymaps = {
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
			},
		},
	},
}
