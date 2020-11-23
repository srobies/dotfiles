let g:ale_disable_lsp = 1 " Use LSP from coc
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" Declare the list of plugins.
" Plug 'jackguo380/vim-lsp-cxx-highlight' " Treesitter covers this plugin.
" Will probably remove

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'
Plug 'Yggdroot/indentLine'
Plug 'simnalamburt/vim-mundo'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rakr/vim-one'
" Plug 'sheerun/vim-polyglot' " Treesitter covers this plugin
Plug 'maximbaz/lightline-ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
"Plug 'nprindle/lc3.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'lambdalisue/suda.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:vimspector_enable_mappings = 'HUMAN'
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
set colorcolumn=120
"New lines inherit indentation of previous lines
set autoindent
set cindent
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
"set clipboard=unnamedplus
"Visual autocomplete for command menu
set wildmenu
"Enable true color support
" set termguicolors
" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"Change color scheme to one colorscheme
set background=dark
set t_Co=256
colorscheme one
"Enable the mouse. Just using for adjusting window sizes
set mouse=a
" Lightline config
"Change lightline to one colorscheme
let g:lightline = {
	  \ 'colorscheme': 'one',
	  \ 'active': {
	  \   'left': [ [ 'mode', 'paste' ],
	  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
	  \ },
	  \ 'component_function': {
	  \   'cocstatus': 'coc#status',
      \   'wordcount': 'WordCount'
	  \ },
	  \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ], [ 'lineinfo' ], [ 'percent', 'wordcount' ], [ 'fileformat', 'fileencoding', 'filetype' ]] }

let g:python_highlight_all = 1
let g:python3_host_prog = '~/python_venvs/nvim/bin/python3'
if executable('rg')
    let g:rg_derive_root='true'
endif

"Rebinds
let mapleader=' '
"Bind esc to jk
inoremap jk <esc>
"Clear search highlight
nnoremap <leader>c :nohlsearch<CR>
" Map terminal exit to esc
tnoremap <Esc> <C-\><C-n>
" Insert mode navigation keys
" inoremap <C-k> <Up>
" inoremap <C-j> <Down>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" Better navigation keys
" nnoremap <leader>h     ^
" nnoremap <leader>l     $
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>
nnoremap <leader>u :MundoToggle<CR>
nnoremap <leader>/ :Rg<SPACE>
nnoremap <leader><bar> :vsp<CR>
nnoremap <leader>- :sp<CR>
" Make tab behave as expected in visual and normal mode
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
"Maps :Files to <leader>-f binding
nnoremap <leader>f :Files<Cr>
"Go to last buffer
nnoremap <leader>` <C-^> 
"Debugger rebinds
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
" nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
" nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
" nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
" nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
" nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
" nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dl <Plug>VimspectorStepInto
nnoremap <leader>dj <Plug>VimspectorStepOver
nnoremap <leader>dh <Plug>VimspectorStepOut
nnoremap <leader>dr <Plug>VimspectorRestart
nnoremap <leader>dc :call vimspector#Continue()<CR>

nnoremap <leader>drc <Plug>VimspectorRunToCursor
nnoremap <leader>dbt <Plug>VimspectorToggleBreakpoint
nnoremap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

" Suda.vim config
let g:suda#prefix = ['suda:/', 'sudo:/']

"Mundo config
let g:mundo_preview_bottom = 1
let g:mundo_width = 30

let g:indentLine_char = '|'

" Toggles netrw with <leader>e
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
" let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_banner = 0
" Change directory to the current buffer when opening files.
" set autochdir

"coc.nvim config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Formatting
xmap <leader>gf <Plug>(coc-format-selected)
nmap <leader>gf <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Pease see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "bash","c","cpp","lua","python","verilog", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = {"bash","c","cpp","lua","python","verilog"},              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
