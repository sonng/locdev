-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local utils = require("utils")

-- Setup Python Properly
if utils.executable('python') then
    vim.g.python3_host_prog = fn.exepath('python')
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Highly extendable fuzzy finder over lists.
  { 'nvim-telescope/telescope.nvim', 
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  -- More features for the Wildmenu
  { 'gelguy/wilder.nvim' },

  -- A tree like view for symbols using LSP
  { 'simrat39/symbols-outline.nvim' },

  -- A tree view file browser
  { 'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  -- Better syntax highlighting
  { 'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
  },

  -- Show current context on top of the file
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- Basically Zero ~ Low config LSP
  { 'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
          -- LSP Support
          { 'neovim/nvim-lspconfig'},
          { 'williamboman/mason.nvim',
            build = ":MasonUpdate",
          },
          {'williamboman/mason-lspconfig.nvim'},

          -- Rust
          {'simrat39/rust-tools.nvim'},

          -- Debugging
          {'nvim-lua/plenary.nvim'},
          {'mfussenegger/nvim-dap'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets
          {
            'L3MON4D3/LuaSnip',
            version = "v2.*",
            build = "make install_jsregexp"
          },
          {'rafamadriz/friendly-snippets'},
      }
  },

  -- Harpoon
  { 'ThePrimeagen/harpoon',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
    }
  },

  -- Markdown Preview
  { "iamcco/markdown-preview.nvim",
    build  = function() vim.fn["mkdp#util#install"]() end,
  },

  -- HOP!
  { 'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

  -- Tmux 
  { "tmux-plugins/vim-tmux",
    ft = { "tmux" } ,
    enabled = function() return utils.executable("tmux") end
  },

  -- Copilot
  { 'github/copilot.vim' },

  -- Lua/Nvim Development
  { "folke/neodev.nvim", opts = {} },
  { 'milisims/nvim-luaref' },

  -- Themes
  { "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd('colorscheme catppuccin')
    end,
    enabled = false,
  },

  { "mcchrish/zenbones.nvim",
    config = function()
        vim.cmd('colorscheme rosebones')
    end,
    dependencies = {
      'rktjmp/lush.nvim',
    },
  },

  -- Status Line
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
  },

  -- Indent Line
  { 'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
  },

  -- Dialek
  { dir = '~/workspace/projects/dialek' }

})

