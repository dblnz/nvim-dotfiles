return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- dependencies = { { "nvim-mini/mini.icons", opts = {} } },

	lazy = false,
	opts = {
		default_file_explorer = true,

		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},

		view_options = {
			show_hidden = true,
		},

		float = {
			border = "rounded",
			max_width = 80,
			max_height = 30,
		},

		keymaps = {
			["<CR>"] = "actions.select",
			["-"] = "actions.parent",
			["_"] = { "actions.open_cwd", mode = "n" },

			-- splits
			["<C-s>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-p>"] = "actions.preview",

			-- useful actions
			["<C-c>"] = { "actions.close", mode = "n" },
			["<C-l>"] = "actions.refresh",
			["g."] = "actions.toggle_hidden",

			-- optional but nice
			["gx"] = "actions.open_external",
			["g?"] = { "actions.show_help", mode = "n" },
		},
	},

	keys = {
		-- netrw-style (most important)
		{
			"<leader>e",
			"<CMD>Oil<CR>",
			desc = "Open parent dir (Oil)",
		},
		-- optional: open at cwd
		{
			"<leader>E",
			function()
				require("oil").open(vim.loop.cwd())
			end,
			desc = "Oil cwd",
		},

		-- float (neo-tree replacement)
		{
			"-",
			function()
				require("oil").open_float()
			end,
			desc = "Oil float",
		},
	},
}
