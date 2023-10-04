local keymap = vim.keymap

-- Do not yank with x
keymap.set('n', 'x', '"_x', {
  desc = 'Delete without yank',
})

-- Save file like any other applciation
keymap.set('n', '<C-s>', '<cmd>w<CR>', {
  desc = 'Save file',
  silent = true,
})

-- copy entire file
keymap.set('n', '<C-c>', '<cmd>%y+<CR>', {
  desc = 'Copy whole file',
  silent = true,
})

-- Increment/decrement
keymap.set('n', '+', '<C-a>', {
  desc = 'Increment number',
})
keymap.set('n', '-', '<C-x>', {
  desc = 'Decrement number',
})

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d', {
  desc = 'Delete word backwards',
})

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G', {
  desc = 'Select all',
})

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', {
  desc = 'Create new tab buffer',
  silent = true,
})
keymap.set('n', 'tc', ':tabclose<Return>', {
  desc = 'Close current tab buffer',
  silent = true,
})
keymap.set('n', 'te', ':tabedit<Return>', {
  desc = 'Create new tab buffer',
  silent = true,
})
keymap.set('n', 'te', ':tabedit<Return>', {
  desc = 'Create new tab buffer',
  silent = true,
})
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', {
  desc = 'split window horizontal',
  silent = true,
})
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', {
  desc = 'spit window vertical',
  silent = true,
})
keymap.set('n', 'sq', '<C-w>q', {
  desc = 'close currnet window',
  silent = true,
})
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w', { desc="change window" })
keymap.set('', 'sh', '<C-w>h', {
  desc = 'Move to left window',
})
keymap.set('', 'sj', '<C-w>j', {
  desc = 'Move to down window',
})
keymap.set('', 'sk', '<C-w>k', {
  desc = 'Move to up window',
})
keymap.set('', 'sl', '<C-w>l', {
  desc = 'Move to right window',
})

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><', {
  desc = 'Decrease width of window',
})
keymap.set('n', '<C-w><right>', '<C-w>>', {
  desc = 'Increase width of window',
})
keymap.set('n', '<C-w><up>', '<C-w>+', {
  desc = 'Increase height of window',
})
keymap.set('n', '<C-w><down>', '<C-w>-', {
  desc = 'Decrease height of window',
})

-- format
keymap.set('n', '<leader>fm', function()
  vim.lsp.buf.format {
    async = true,
  }
end, {
  desc = 'LSP formatting',
})

-- toggle comment in both modes
keymap.set('n', '<leader>/', function()
  require('Comment.api').toggle.linewise.current()
end, {
  desc = 'Toggle comment',
  silent = true,
})
