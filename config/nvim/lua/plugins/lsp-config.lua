return {
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(vim.cmd, "MasonUpdate")
		end,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					--lsp
					"bashls",
					"cssls",
					"eslint",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"marksman",
					--"prismals",
					--"tailwindcss",
					"tsserver",
				},
			})
		end,
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "info" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
			vim.keymap.set("n", "<leader>se", function()
				vim.diagnostic.open_float({ border = "rounded" })
			end, { desc = "show full message" })
		end,
	},
}
