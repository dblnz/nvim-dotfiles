local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})


-- Document highlight on CursorHold
local lsp_au = vim.api.nvim_create_augroup("dblnz_lsp_attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_au,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data and ev.data.client_id or 0)
		if not client then return end

		if client:supports_method("textDocument/documentHighlight") then
			local hl_au = vim.api.nvim_create_augroup("dblnz_lsp_document_highlight_" .. ev.buf, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = hl_au,
				buffer = ev.buf,
				callback = function() vim.lsp.buf.document_highlight() end,
				desc = "LSP document highlight",
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
				group = hl_au,
				buffer = ev.buf,
				callback = function() vim.lsp.buf.clear_references() end,
				desc = "Clear LSP references",
			})
		end
	end,
	desc = "Initialize LSP UI features on attach",
})

-- LSP progress in statusline
vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("dblnz_lsp_progress", { clear = true }),
	callback = function(ev)
		local value = ev.data and ev.data.params and ev.data.params.value
		if not value then return end
		if value.kind == "end" then
			vim.g.lsp_progress_msg = ''
			-- After a task finishes, re-request inlay hints only if the buffer
			-- has none yet (avoids flicker when hints are already displayed)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client then
				vim.schedule(function()
					for bufnr in pairs(client.attached_buffers) do
						local hints = vim.lsp.inlay_hint.get({ bufnr = bufnr })
						if #hints == 0 then
							vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end
					end
				end)
			end
		else
			local parts = {}
			if value.title and value.title ~= '' then parts[#parts + 1] = value.title end
			if value.message and value.message ~= '' then parts[#parts + 1] = value.message end
			if value.percentage then parts[#parts + 1] = value.percentage .. '%%' end
			vim.g.lsp_progress_msg = table.concat(parts, ' ')
		end
		local ok, lualine = pcall(require, 'lualine')
		if ok then lualine.refresh() end
	end,
})

-- Close special buffers with q
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("dblnz_close_with_q", { clear = true }),
	pattern = { "fugitive", "fugitiveblame", "git", "gitcommit", "help", "qf" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close buffer" })
	end,
})
