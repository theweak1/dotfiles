local status_ok, null_ls = pcall(require, 'neo-tree')
if not status_ok then
    print 'neo-tree is not isntalled.'
    return
end

vim.keymap.set('n', '<leader>f', ':Neotree toggle<CR>', {
    noremap = true,
})

vim.keymap.set('n', '<leader>e', ':Neotree focus<CR>', {
    noremap = true,
})
