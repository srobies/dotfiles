return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'windwp/nvim-autopairs'
    use 'glepnir/lspsaga.nvim'
    use 'christoomey/vim-tmux-navigator'
    use 'tversteeg/registers.nvim'
    use 'kevinhwang91/nvim-bqf'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'b3nj5m1n/kommentary'
    use 'tpope/vim-repeat'
    use 'justinmk/vim-sneak'
    use 'akinsho/nvim-toggleterm.lua'
    -- use 'glepnir/zephyr-nvim'
    use 'mfussenegger/nvim-dap'
    use 'folke/tokyonight.nvim'
    use {'lervag/vimtex', ft = {'tex'}, opt=true}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'ledger/vim-ledger', ft={'ledger'}, opt=true}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lukas-reineke/indent-blankline.nvim', branch='lua'}
    use {'glepnir/galaxyline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'folke/todo-comments.nvim', requires = {'folke/trouble.nvim'}}
    use {'neovim/nvim-lspconfig',
        requires = {{'hrsh7th/nvim-compe'},{'hrsh7th/vim-vsnip'},{'rafamadriz/friendly-snippets'}}
    }
    use {'kabouzeid/nvim-lspinstall', requires = {'neovim/nvim-lspconfig'}}
    use {'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'},{'nvim-lua/popup.nvim'}}
    }
end)
