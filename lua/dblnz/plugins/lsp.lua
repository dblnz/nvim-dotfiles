return {
	-- LSP config, keymaps, and server enables
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Set capabilities for all servers via the wildcard
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Server-specific overrides
		vim.lsp.config("clangd", {
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME },
					},
					telemetry = { enable = false },
				},
			},
		})

		vim.lsp.config("omnisharp", {
			handlers = {
				["textDocument/definition"] = function(...)
					return require("omnisharp_extended").handler(...)
				end,
			},
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
		})

		-- Diagnostics
		vim.diagnostic.config({
			severity_sort = true,
			update_in_insert = false,
			float = { border = "rounded", source = "if_many" },
			underline = true,
			virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
					[vim.diagnostic.severity.INFO] = "I",
					[vim.diagnostic.severity.HINT] = "H",
				},
			},
		})

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
			callback = function(ev)
				local buf = ev.buf
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
				end

				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gr", function()
					require("telescope.builtin").lsp_references()
				end, "Go to references")
				map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
			end,
		})

		-- Explicitly enable all LSP servers
		vim.lsp.enable({
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
			"clangd",
			"omnisharp",
		})
	end,
}
