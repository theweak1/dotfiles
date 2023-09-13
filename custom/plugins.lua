local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",

     config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "NvChad/ui",
    branch = "v2.0",
    lazy = false,
    config = function()
      require "nvchad"
      vim.api.nvim_command('highlight Normal ctermbg=236')
      vim.api.nvim_command('highlight Normal ctermfg=NONE')
      vim.api.nvim_command('highlight Normal cterm=NONE')
      vim.api.nvim_command('highlight Normal guibg=NONE')
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",
        "bash",
        "yaml",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "markdown",
        -- "vue", "svelte",

       -- low level
        "c",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return {
        ensure_installed = {

          -- Web development
          "css-lsp",
          "deno",
          "grammarly-languageserver",
          "html-lsp",
          "json-lsp",
          "jsonlint",
          "prisma-language-server",
          "tailwindcss-language-server",
          "typescript-language-server",

          -- Core
          "lua-language-server",

          -- Markdown
          "marksman",
          
          -- formatter
          "prettier",
          "prettierd",
         
          -- Yaml for ansible
          -- "yaml-language-server",
          -- "yamllint",
          -- "yamlfix",
          -- "yamlfmt",
        },
      }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- Custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreview", "MarkdownPreviewStop"},
    lazy = false,
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
        vim.g.mkdp_theme = 'dark'
    end
  },
}
return plugins
