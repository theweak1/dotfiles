return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add file to harpoon" })
    vim.keymap.set("n", "<leader>hl", ui.toggle_quick_menu, { desc = "Show harpooned files" })

    vim.keymap.set("n", "<M-h>", function()
      ui.nav_file(1)
    end, { desc = "move to first mark file" })
    vim.keymap.set("n", "<M-j>", function()
      ui.nav_file(2)
    end, { desc = "move to second mark file" })
    vim.keymap.set("n", "<M-k>", function()
      ui.nav_file(3)
    end, { desc = "move to third mark file" })
    vim.keymap.set("n", "<M-l>", function()
      ui.nav_file(4)
    end, { desc = "move to fourth mark file" })
  end,
}
