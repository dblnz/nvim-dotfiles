-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ensure LSP-powered features are initialized as soon as a server attaches
local lsp_au = vim.api.nvim_create_augroup("dblnz_lsp_attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_au,
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data and ev.data.client_id or 0)
		if not client then return end

		-- Inlay hints (if supported)
		if client.supports_method and client:supports_method("textDocument/inlayHint") then
			local ok = pcall(function()
				if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				elseif vim.lsp.inlay_hint then
					-- older API
					vim.lsp.inlay_hint(bufnr, true)
				end
			end)
			if not ok then
				-- no-op if API differs
			end
		end

		-- Semantic tokens (kick-start on attach if supported)
		if client.supports_method and client:supports_method("textDocument/semanticTokens/full") then
			pcall(function()
				if vim.lsp.semantic_tokens and vim.lsp.semantic_tokens.start then
					vim.lsp.semantic_tokens.start(bufnr, client.id)
				elseif vim.lsp.semantic_tokens and vim.lsp.semantic_tokens.on_attach then
					vim.lsp.semantic_tokens.on_attach(client, bufnr)
				end
			end)
		end

		-- Document highlight (CursorHold) if supported
		if client.supports_method and client:supports_method("textDocument/documentHighlight") then
			local hl_au = vim.api.nvim_create_augroup("dblnz_lsp_document_highlight_" .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = hl_au,
				buffer = bufnr,
				callback = function()
					pcall(vim.lsp.buf.document_highlight)
				end,
				desc = "LSP document highlight",
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
				group = hl_au,
				buffer = bufnr,
				callback = function()
					pcall(vim.lsp.buf.clear_references)
				end,
				desc = "Clear LSP references",
			})
		end
	end,
	desc = "Initialize LSP UI features on attach",
})
