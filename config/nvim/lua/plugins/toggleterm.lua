return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		function _G.set_terminal_keymaps()
			local opts = {
				noremap = true,
			}
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
		})
    
        local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

		-- Function to generate the script command
		local function noteTakingScript()
			local date = os.date("%Y-%m-%d")
			local noteFilename = vim.fn.expand("$HOME") .. "/Notes/src/note-" .. date .. ".md"
			local script = "bash -c 'if [ ! -f "
				.. noteFilename
				.. ' ]; then echo "# Notes for '
				.. date
				.. '" > '
				.. noteFilename
				.. '; fi; nvim -c "norm Go" -c "norm Go## $(date +%H:%M)" -c "norm G2o" -c "norm zz" -c "startinsert" '
				.. noteFilename
				.. "'"
			return script
		end

		-- Create a new terminal for the note-taking script
		local noteTerminal = Terminal:new({
			cmd = noteTakingScript(),
			hidden = true,
			direction = "float",
			close_on_exit = true,
		})

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

        function _LAZYDOCKER_TOGGLE()
            lazydocker:toggle()
        end
		-- Function to toggle the note-taking terminal
		function _NOTES_TOGGLE()
			noteTerminal:toggle()
		end

		vim.keymap.set("n", "<leader>lg", ":lua _LAZYGIT_TOGGLE()<CR>", {
			noremap = true,
			desc = "open lazygit",
		})
		vim.keymap.set("n", "<leader>ld", ":lua _LAZYDOCKER_TOGGLE()<CR>", {
			noremap = true,
			desc = "open lazydocker",
		})
		-- Keybinding to toggle the note-taking terminal
		vim.keymap.set("n", "<leader>nt", ":lua _NOTES_TOGGLE()<CR>", {
			noremap = true,
			desc = "Open days note",
		})
	end,
}
