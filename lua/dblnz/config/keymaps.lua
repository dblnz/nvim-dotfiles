local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Yank to end of line
map({ "n" }, "Y", "yg$", { desc = "Yank to end of line" })
-- Append line below, keep cursor position
map({ "n" }, "J", "mzJ`z", { desc = "Append line below and remove CR LF" })
-- Search and center
map({ "n" }, "n", "nzzzv", { desc = "Search next and center" })
map({ "n" }, "N", "Nzzzv", { desc = "Search previous and center" })

-- Copy/paste from system clipboard
map({ "n" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map({ "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map({ "n" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard" })
map({ "n" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
map({ "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
map({ "n" }, "<leader>P", '"+P', { desc = "Paste from clipboard" })

-- Change/delete without yanking
map({ "n" }, "<leader>c", '"_c', { desc = "Change without yanking" })
map({ "v" }, "<leader>c", '"_c', { desc = "Change without yanking" })
map({ "n" }, "<leader>C", '"_C', { desc = "Change without yanking" })
map({ "v" }, "<leader>C", '"_C', { desc = "Change without yanking" })
map({ "n" }, "<leader>x", '"_x', { desc = "Delete without yanking" })
map({ "v" }, "<leader>x", '"_x', { desc = "Delete without yanking" })
map({ "n" }, "<leader>X", '"_X', { desc = "Delete without yanking" })
map({ "v" }, "<leader>X", '"_X', { desc = "Delete without yanking" })
map({ "n" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n" }, "<leader>D", '"_D', { desc = "Delete without yanking" })
map({ "v" }, "<leader>D", '"_D', { desc = "Delete without yanking" })

-- Replace word under cursor
map({ "n" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Unmap Q, remap quit and write
map({ "n" }, "Q", "<nop>", { desc = "Unmap Q" })
map({ "n" }, "<leader>q", ":confirm q<CR>", { desc = "Quit" })
map({ "v" }, "<leader>q", ":confirm q<CR>", { desc = "Quit" })
map({ "n" }, "<leader>w", ":w<CR>", { desc = "Write" })
map({ "v" }, "<leader>w", ":w<CR>", { desc = "Write" })

-- Move selected lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Toggle light/dark theme
map("n", "<leader>ut", function()
	if vim.g.colors_name == "catppuccin-latte" then
		vim.cmd.colorscheme("catppuccin-mocha")
	else
		vim.cmd.colorscheme("catppuccin-latte")
	end
end, { desc = "Toggle light/dark theme" })
