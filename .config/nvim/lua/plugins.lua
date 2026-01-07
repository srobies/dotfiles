local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	concurrency = 8,
	spec = {
		{
			'gbprod/cutlass.nvim',
			opts = {
				cut_key = "m",
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
				dependencies = {
					'mfussenegger/nvim-dap',
					'nvim-neotest/nvim-nio'
				},
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
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',
      opts = {
        keymap = {
          preset = "enter",
          ["<Tab>"] = {
            "select_next",
            "snippet_forward",
            "fallback",
          },
          ["<S-Tab>"] = {
            "select_prev",
            "snippet_backward",
            "fallback",
          },
        },
        signature = { enabled = true }
      }
		},
		-- {
		-- 	'L3MON4D3/LuaSnip',
		-- 	dependencies = {
		-- 		'rafamadriz/friendly-snippets'
		-- 	}
		-- },
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
},
})
