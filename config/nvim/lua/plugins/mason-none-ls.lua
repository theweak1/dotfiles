return {
  "jayp0521/mason-null-ls.nvim",
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        --linters
        "eslint_d",

        --formatters
        "prettier",
        "stylua",
      },
    })
  end,
}
