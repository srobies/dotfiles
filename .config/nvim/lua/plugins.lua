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

require('lazy').setup({
	{
    'gbprod/cutlass.nvim',
		opts = {
			cut_key = "x",
		}
	},
  {url = 'http://gitlab.com/HiPhish/rainbow-delimiters.nvim'},
  'glepnir/lspsaga.nvim',
  'unblevable/quick-scope',
  'kristijanhusak/orgmode.nvim',
  {
    'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup{}
    end
  },
  'windwp/nvim-autopairs',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  {
      'rcarriga/nvim-dap-ui',
      dependencies = {'mfussenegger/nvim-dap'},
      config = function()
          require('dapui').setup{}
      end
  },
  'folke/tokyonight.nvim',
  'kevinhwang91/nvim-bqf',
  {
      'terrortylor/nvim-comment',
      config = function ()
          require('nvim_comment').setup {
              comment_empty = false
          }
      end
  },
  'tpope/vim-repeat',
  {
      'akinsho/nvim-toggleterm.lua',
      config = function ()
          require('toggleterm').setup{
              open_mapping = [[<C-t>]]
          }
      end
  },
  'lervag/vimtex',
  {
      'lewis6991/gitsigns.nvim',
      dependencies = {'nvim-lua/plenary.nvim'},
      event = 'VimEnter', -- Otherwise it produces an error when a :Git buffer is open.
      config = function ()
          require('gitsigns').setup{
              numhl = true,
          }
      end
  },
  {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
  },
  {'lukas-reineke/indent-blankline.nvim', main = 'ibl'},
  {
    'windwp/windline.nvim',
      dependencies = {'kyazdani42/nvim-web-devicons'}},
  {
    "folke/trouble.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons"},
    config = function()
      require("trouble").setup {}
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim", 'folke/trouble.nvim'},
    config = function()
      require("todo-comments").setup {}
    end
  },
  'neovim/nvim-lspconfig',
  {
      'hrsh7th/nvim-cmp',
      dependencies = {
          'ray-x/cmp-treesitter',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-omni',
          'lukas-reineke/cmp-rg',
          'saadparwaiz1/cmp_luasnip'
      }
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets'
    }
  },
  'ray-x/lsp_signature.nvim',
  {
    'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
      }
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
})
