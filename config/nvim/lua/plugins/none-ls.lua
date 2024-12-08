return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
			},
		})

		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "format file" })
	end,
}
