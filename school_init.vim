let g:lc3_detect_asm = 1
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" Declare the list of plugins.
Plug 'jremmen/vim-ripgrep'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow' 
Plug 'nprindle/lc3.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'justinmk/vim-sneak'
Plug 'lambdalisue/suda.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
syntax on
set undodir=~/.config/nvim/undodir
set undofile
set colorcolumn=80
"New lines inherit indentation of previous lines
set autoindent
"Enable search highlighting
set hlsearch
"Ignore case when searching
set ignorecase
"Switch to case-sensitive when query contains uppercase letter
set smartcase
"Hybrid line number
set number relativenumber
set nu rnu
set nowrap
"Spell check for English
"set spell spelllang=en_us
"Identify open and close brace positions
set showmatch
"Searches are you type
set incsearch
"Change to using system clipboard instead of unnamed register
set clipboard=unnamedplus
"Visual autocomplete for command menu
set wildmenu
"Enable true color support
set termguicolors
set updatetime=100
"Change color scheme to palenight color
set background=dark
colorscheme palenight
"Change lightline to palenight colorscheme
let g:lightline = { 'colorscheme': 'palenight' }
"Enable Tab guide on startup
let g:indent_guides_enable_on_vim_startup = 1
"Enable rainbow at startup
let g:rainbow_active = 1
let g:python_highlight_all = 1

if executable('rg')
    let g:rg_derive_root='true'
endif

"Rebinds
let mapleader=' '
"Bind esc to jk
inoremap jk <esc>
" Insert mode navigation keys
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" Better navigation keys
nnoremap <leader>h     ^
nnoremap <leader>l     $
nnoremap <leader>H :wincmd h<CR>
nnoremap <leader>J :wincmd j<CR>
nnoremap <leader>K :wincmd k<CR>
nnoremap <leader>L :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <Leader>ps :Rg<SPACE>
" Make tab behave as expected in visual and normal mode
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
"Maps :Files to Ctrl-p binding
nnoremap <C-p> :Files<Cr>

" Suda.vim config
let g:suda#prefix = ['suda:/', 'sudo:/']
" Sneak config
let g:sneak#label = 1

" case insensitive sneak
let g:sneak#use_ic_scs = 1
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1 
endif

" Use netrw like Nerdtree
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
nnoremap <silent> <leader>e :call ToggleVExplorer()<CR>
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Change directory to the current buffer when opening files.
set autochdir
