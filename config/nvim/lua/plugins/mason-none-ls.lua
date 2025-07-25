local servers = {
  --linters

  --formatters
  "stylua",
  "yamlfmt",
}
return {
  "jayp0521/mason-null-ls.nvim",
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = servers,
    })
  end,
}
