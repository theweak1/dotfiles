return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("bufferline").setup({
			options = {
				mode = "tabs",
				separator_style = "slant",
				always_show_bufferline = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
			highlights = {
				separator = {
					fg = "#073642",
					bg = "#002b36",
				},
				separator_selected = {
					fg = "#073642",
				},
				background = {
					fg = "#657b83",
					bg = "#002b36",
				},
				buffer_selected = {
					fg = "#fdf6e3",
					bold = true,
				},
				fill = {
					bg = "#073642",
				},
			},
		})

		vim.keymap.set("n", "<M-n>", "<Cmd>BufferLineCycleNext<CR>", {})
		vim.keymap.set("n", "<M-p>", "<Cmd>BufferLineCyclePrev<CR>", {})
	end,
}
