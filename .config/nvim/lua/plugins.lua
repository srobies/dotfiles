return require('packer').startup(function()
  use 'glepnir/lspsaga.nvim'
  use {
    'jinh0/eyeliner.nvim',
    config = function()
      require'eyeliner'.setup {
        highlight_on_key = true
      }
    end
  }
  use 'wbthomason/packer.nvim'
  use 'kristijanhusak/orgmode.nvim'
  use {'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup{}
    end
  }
  use 'windwp/nvim-autopairs'
  use 'christoomey/vim-tmux-navigator'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'mfussenegger/nvim-dap'
  use {
      'rcarriga/nvim-dap-ui',
      requires = {'mfussenegger/nvim-dap'},
      config = function()
          require('dapui').setup{}
      end
  }
  use 'folke/tokyonight.nvim'
  use 'kevinhwang91/nvim-bqf'
  use {
      'terrortylor/nvim-comment',
      config = function ()
          require('nvim_comment').setup {
              comment_empty = false
          }
      end
  }
  use 'tpope/vim-repeat'
  use {
      'akinsho/nvim-toggleterm.lua',
      config = function ()
          require('toggleterm').setup{
              open_mapping = [[<C-t>]]
          }
      end
  }
  use 'lervag/vimtex'
 use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      event = 'VimEnter', -- Otherwise it produces an error when a :Git buffer is open.
      config = function ()
          require('gitsigns').setup{
              numhl = true,
          }
      end
  }
  use 'ledger/vim-ledger'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use {'windwp/windline.nvim',
      requires = {'kyazdani42/nvim-web-devicons'}}
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = {{"nvim-lua/plenary.nvim"}, {'folke/trouble.nvim'}},
    config = function()
      require("todo-comments").setup {}
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'L3MON4D3/LuaSnip'
  use {
      'hrsh7th/nvim-cmp',
      requires = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'ray-x/cmp-treesitter',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-omni',
        'lukas-reineke/cmp-rg',
      }
  }
  use 'ray-x/lsp_signature.nvim'
  use {'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/plenary.nvim'},{'nvim-lua/popup.nvim'}}
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
end)
