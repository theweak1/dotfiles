return {
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.0",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        tag = "0.3.4",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "~/orgfiles",
      })

      -- Auto-save buffers when leaving them
      vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
        pattern = {"*.org"},
        callback = function()
          if vim.bo.modified then
            vim.cmd("silent! write")
          end
        end,
      })

      -- Disable confirmation prompts when closing modified buffers
      vim.o.confirm = false
    end,
  },
}

