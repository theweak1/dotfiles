local Terminal = require("toggleterm.terminal").Terminal

-- Create a new terminal instance
local lazygit_term = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- Function to toggle the lazygit terminal
function _LAZYGIT_TOGGLE()
    lazygit_term:toggle()
end

-- Keybinding to toggle the terminal
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {noremap = true, silent = true})
