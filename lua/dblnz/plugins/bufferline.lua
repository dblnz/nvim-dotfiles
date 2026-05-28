return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				close_command = function(n) require("mini.bufremove").delete(n) end,
				right_mouse_command = function(n) require("mini.bufremove").delete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
			},
		},
		keys = {
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to the Right" },
			{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to the Left" },
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{ "<leader>bd", function() require("mini.bufremove").delete(0) end, desc = "Delete Buffer" },
		},
	},
}
