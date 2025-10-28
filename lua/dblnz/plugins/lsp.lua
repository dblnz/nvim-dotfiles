
return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		dependencies = {
			{
				"jose-elias-alvarez/typescript.nvim",
				init = function()
					require("lazyvim.util").lsp.on_attach(function(_, buffer)
						-- stylua: ignore
						vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
						vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
					end)
				end,
			},
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				pyright = {},
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
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
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},
}
