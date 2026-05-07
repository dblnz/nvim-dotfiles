return {
	-- LSP config, keymaps, and server enables
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Set capabilities for all servers via the wildcard
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Server-specific overrides
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

		vim.lsp.config("rust_analyzer", {
			root_markers = { "Cargo.toml", "rust-project.json" },
			settings = {
				["rust-analyzer"] = {
					diagnostics = { enable = true },
					checkOnSave = true,
					procMacro = { enable = true },
				},
			},
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

		-- Refresh inlay hints after dynamic capability registration
		-- (rust-analyzer registers textDocument/inlayHint late via dynamic registration)
		local orig_handler = vim.lsp.handlers['client/registerCapability']
		vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
			local result = orig_handler(err, res, ctx)
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			if client then
				vim.schedule(function()
					for bufnr in pairs(client.attached_buffers) do
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end)
			end
			return result
		end

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
			callback = function(ev)
				local buf = ev.buf
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
				end

				-- Enable inlay hints for this buffer
				vim.lsp.inlay_hint.enable(true, { bufnr = buf })

				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gr", function()
					require("telescope.builtin").lsp_references()
				end, "Go to references")
			end,
		})

	end,
}
