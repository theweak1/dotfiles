return {
  {
    "williamboman/mason.nvim",
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
          "gopls",
          "jsonls",
          "lua_ls",
          "marksman",
          "tsserver",

          --linters
          "eslint_d",

          --formatters
          "prettier",
          "stylua",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()


      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "info" })
      vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "go to definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
    end,
  },
}
