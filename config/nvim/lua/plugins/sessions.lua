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

		-- Session lens functionality requires the separate session-lens plugin
		-- For now, use :RestoreSession or :DeleteSession commands directly
		-- vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
		-- 	noremap = true,
		-- 	desc = "Show all auto sessions",
		-- })

		vim.keymap.set("n", "<leader>ds", "<cmd> Autosession delete<CR>", {
			noremap = true,
			desc = "delete a auto sessions",
		})
	end,
}
