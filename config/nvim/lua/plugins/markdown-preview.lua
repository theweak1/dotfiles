return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown", "org" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.g.mkdp_filetypes = { "markdown", "org" }
    vim.g.mkdp_theme = "dark"
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { noremap = true })
  end,
}
