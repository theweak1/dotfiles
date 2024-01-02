-- [LSP Setup]
local lsp = require 'lsp-zero'

lsp.preset {
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = true,
  },
}

lsp.ensure_installed {
  'bashls',
  'cssls',
  'eslint',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'prismals',
  'tsserver',
  'tailwindcss',
}

-- Fix Undefined global 'vim' issue
lsp.nvim_workspace()

-- [Auto Complete Configuration]
local cmp = require 'cmp'
local cmp_select = {
  behavior = cmp.SelectBehavior.Select,
}
local cmp_mappings = lsp.defaults.cmp_mappings {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm {
    select = true,
  },
}

lsp.setup_nvim_cmp {
  mapping = cmp_mappings,
}

lsp.set_preferences {
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
}

-- [LSP Customization]
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps {
    buffer = bufnr,
  }
  lsp.buffer_autoformat()

  local opts = {
    buffer = bufnr,
    remap = false,
  }

  vim.keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>', {
    buffer = true,
  })
  vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}
