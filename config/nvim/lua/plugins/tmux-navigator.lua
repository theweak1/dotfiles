return {
  "christoomey/vim-tmux-navigator",

  vim.keymap.set('n', 'C-h', ':TmuxNagiateLeft<CR>'),
  vim.keymap.set('n', 'C-j', ':TmuxNagiateDown<CR>'),
  vim.keymap.set('n', 'C-k', ':TmuxNagiateUp<CR>'),
  vim.keymap.set('n', 'C-l', ':TmuxNagiateRight<CR>')
}
