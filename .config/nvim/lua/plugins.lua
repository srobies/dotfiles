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
                    width = 60
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
        'b3nj5m1n/kommentary',
        config = function ()
            require('kommentary.config').configure_language("default", {
                prefer_single_line_comments = true,
            })
        end
    }
    use 'tpope/vim-repeat'
    use 'justinmk/vim-sneak'
    use {
        'akinsho/nvim-toggleterm.lua',
        opt = true,
        cmd = 'ToggleTerm',
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
        'hrsh7th/nvim-compe',
        requires = {{'hrsh7th/vim-vsnip'},{'rafamadriz/friendly-snippets'}},
    }
    use {
        'kabouzeid/nvim-lspinstall',
        requires = {'neovim/nvim-lspconfig'},
        config = function ()
            require'lspinstall'.setup() -- important
            local servers = require'lspinstall'.installed_servers()
            for _, server in pairs(servers) do
              require'lspconfig'[server].setup{}
            end
        end
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
