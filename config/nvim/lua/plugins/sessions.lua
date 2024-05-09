local directories_to_ignore = {
	"~/",
	"~/.dotfiles/",
	"~/.dotfiles/**",
	"~/Projects",
	"~/Downloads",
	"/",
}

return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_suppress_dirs = directories_to_ignore,
		})
		session_lens = {
			buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
			load_on_setup = true,
			theme_conf = { border = true },
			previewer = false,
		}
		vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
			noremap = true,
			desc = "Show all auto sessions",
		})
		vim.keymap.set("n", "<leader>ds", "<cmd> Autosession delete<CR>", {
			noremap = true,
			desc = "delete a auto sessions",
		})
	end,
}
