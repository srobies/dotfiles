return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'windwp/nvim-autopairs'
    use 'glepnir/lspsaga.nvim'
    use 'christoomey/vim-tmux-navigator'
    -- use 'tversteeg/registers.nvim'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'mfussenegger/nvim-dap'
    use {
        'rcarriga/nvim-dap-ui',
        requires = {'mfussenegger/nvim-dap'},
        config = function()
            require('dapui').setup{
                sidebar = {
                    size = 60
                },
                tray = {
                    elements = {},
                }
            }
        end
    }
    use 'folke/tokyonight.nvim'
    use {
        'kevinhwang91/nvim-bqf',
        opt = true,
        ft = {'c', 'cpp', 'py', 'tex', 'sh'}
    }
    use {
        'terrortylor/nvim-comment',
        config = function ()
            require('nvim_comment').setup {
                comment_empty = false
            }
        end
    }
    use 'tpope/vim-repeat'
    use 'justinmk/vim-sneak'
    use {
        'akinsho/nvim-toggleterm.lua',
        config = function ()
            require('toggleterm').setup{
                open_mapping = [[<C-t>]]
            }
        end
    }
    -- use 'glepnir/zephyr-nvim'
    use {'lervag/vimtex', ft = {'tex'}, opt=true}
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function ()
            require('gitsigns').setup{
                numhl = true,
            }
        end
    }
    use {'ledger/vim-ledger'}
    -- , ft={'ledger','journal'}, opt=true}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function ()
            require('nvim-treesitter.configs').setup {
              ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
              highlight = { enable = true },
              autopairs = { enable = true }
        }
        end
    }
    use 'lukas-reineke/indent-blankline.nvim'
    use {'glepnir/galaxyline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
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
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/vim-vsnip',
            'rafamadriz/friendly-snippets',
            'ray-x/cmp-treesitter',
            'hrsh7th/cmp-vsnip',
            'kdheepak/cmp-latex-symbols',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
        }
    }
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
