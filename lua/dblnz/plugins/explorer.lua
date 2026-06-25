return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
		{ "<leader>E", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Explorer on current file" },
	},
	config = function()
		-- Disable netrw (recommended by nvim-tree)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				side = "left",
				width = 35,
			},
			renderer = {
				group_empty = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			filters = {
				dotfiles = false,
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
				},
			},
			update_focused_file = {
				enable = true,
				update_root = false, -- optional
			},
		})
	end,
}
