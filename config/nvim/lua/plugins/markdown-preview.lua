return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	config = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_theme = "dark"
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { noremap = true })
		vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { noremap = true })
	end,
}
