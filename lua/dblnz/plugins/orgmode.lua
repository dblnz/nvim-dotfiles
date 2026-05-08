return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
	},
	config = function()
		local global_dir = vim.fn.expand("~/orgfiles")

		-- Ensure directory exists
		if vim.fn.isdirectory(global_dir) == 0 then
			vim.fn.mkdir(global_dir, "p")
		end

		-- Ensure org files exist
		local files = { "refile.org", "personal.org", "msft.org" }
		for _, file in ipairs(files) do
			local path = global_dir .. "/" .. file
			if vim.fn.filereadable(path) == 0 then
				local f = io.open(path, "w")
				if f then
					f:write("#+TITLE: " .. file:gsub("%.org$", "") .. "\n\n")
					f:close()
				end
			end
		end

		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = { global_dir .. "/**/*" },
			org_default_notes_file = global_dir .. "/refile.org",
			org_refile_targets = {
				{ maxlevel = 3 },
			},
			org_refile_use_outline_path = "file",
			org_outline_path_complete_in_steps = false,
			org_todo_keywords = { "TODO(t)", "IN-PROGRESS(i)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
			org_capture_templates = {
				t = {
					description = "Task",
					template = "* TODO %?\n",
					target = global_dir .. "/refile.org",
				},
			},
		})

		-- Quick open orgfiles directory (toggle)
		local _orgfiles_active = false
		vim.keymap.set("n", "<leader>oG", function()
			local api = require("nvim-tree.api")
			if _orgfiles_active then
				api.tree.change_root(vim.fn.getcwd())
				_orgfiles_active = false
			else
				api.tree.open({ path = global_dir })
				api.tree.change_root(global_dir)
				_orgfiles_active = true
			end
		end, { desc = "Toggle orgfiles directory" })
	end,
}
