return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    require("nvim-treesitter").setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "luap", "markdown", "markdown_inline", "query", "regex", "toml", "vim", "vimdoc" },
    })
  end,
}
