return {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup({})
		vim.keymap.set("n", "tt", "<cmd>:TodoTelescope<CR>", { desc = "Show todo comment in telescope" })
	end,
}
