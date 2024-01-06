return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search for file" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep within project" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
