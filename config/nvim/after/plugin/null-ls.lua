local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
    print 'null-ls is not isntalled.'
    return
end

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = { formatting.eslint, formatting.prettier, formatting.stylua, lint.shellcheck }

null_ls.setup {
    debug = true,
    sources = sources,
}
