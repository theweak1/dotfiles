vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.termguicolors = true
vim.wo.number = true
vim.o.breakindent = true

-- Save file like any other applciation
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", {
	desc = "Save file",
	silent = true,
})

-- copy entire file
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", {
	desc = "Copy whole file",
	silent = true,
})

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", {
	desc = "Select all",
})

-- Split window
vim.keymap.set("n", "ss", ":split<Return><C-w>w", {
	desc = "split window horizontal",
	silent = true,
})
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w", {
	desc = "spit window vertical",
	silent = true,
})
vim.keymap.set("n", "sq", "<C-w>q", {
	desc = "close currnet window",
	silent = true,
})

-- move between windows
vim.keymap.set("", "sh", "<C-w>h", {
	desc = "Move to left window",
})
vim.keymap.set("", "sj", "<C-w>j", {
	desc = "Move to down window",
})
vim.keymap.set("", "sk", "<C-w>k", {
	desc = "Move to up window",
})
vim.keymap.set("", "sl", "<C-w>l", {
	desc = "Move to right window",
})

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><", {
	desc = "Decrease width of window",
})
vim.keymap.set("n", "<C-w><right>", "<C-w>>", {
	desc = "Increase width of window",
})
vim.keymap.set("n", "<C-w><up>", "<C-w>+", {
	desc = "Increase height of window",
})
vim.keymap.set("n", "<C-w><down>", "<C-w>-", {
	desc = "Decrease height of window",
})
