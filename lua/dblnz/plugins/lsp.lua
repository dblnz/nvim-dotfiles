
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		---@class PluginLspOpts
		opts = {
			---@type table<string, lazyvim.lsp.Config|boolean>
			servers = {
				pyright = {},
				ts_ls = {
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
						{
							"<leader>cR",
							function()
								Snacks.rename.rename_file()
							end,
							desc = "Rename File",
							has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
						},
					},
				},
				rust_analyzer = {},
				omnisharp = {
					handlers = {
						["textDocument/definition"] = function(...)
							return require("omnisharp_extended").handler(...)
						end,
					},
					keys = {
						{
							"gd",
							LazyVim.has("telescope.nvim") and function()
								require("omnisharp_extended").telescope_lsp_definitions()
							end or function()
								require("omnisharp_extended").lsp_definitions()
							end,
							desc = "Goto Definition",
						},
					},
					enable_roslyn_analyzers = true,
					organize_imports_on_format = true,
					enable_import_completion = true,
				},
			},
		},
	},
}
