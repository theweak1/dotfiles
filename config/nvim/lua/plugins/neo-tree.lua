return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
            ".git",
					},
				},
			},
			window = {
				width = 30,
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle right<CR>", { desc = "open Neotree" })
		vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { noremap = true, desc = "focus filetree" })
	end,
}
