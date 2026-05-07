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
			-- Include all org files in the directory
			org_agenda_files = { global_dir .. "/**/*" },

			-- Default file for captures
			org_default_notes_file = global_dir .. "/refile.org",

			-- Refile settings
			org_refile_targets = {
				{ maxlevel = 3 },
			},
			org_refile_use_outline_path = "file",
			org_outline_path_complete_in_steps = false,

			-- TODO keywords
			org_todo_keywords = { "TODO(t)", "IN-PROGRESS(i)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },

			-- Single capture template
			org_capture_templates = {
				t = {
					description = "Task",
					template = "* TODO %?\n",
					target = global_dir .. "/refile.org",
				},
			},
		})

		-- Keymaps
		local map = vim.keymap.set

		-- Quick open orgfiles directory
		map("n", "<leader>oG", function()
			vim.cmd("edit " .. global_dir)
		end, { desc = "Open orgfiles directory" })
	end,
}
