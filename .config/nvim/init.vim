" " lua require('init')
lua require('nvim_lsp')
lua require('my_debug')

set completeopt=menuone,noselect
set updatetime=1000
set signcolumn=yes
set listchars=eol:
set list
set timeoutlen=1000
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set autoindent
set cindent
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufNewFile,BufRead neomutt-* setf mail 
autocmd FileType mail setlocal formatoptions+=w
" C/Cpp specific tabsize
autocmd FileType c,cpp set tabstop=2
autocmd FileType c,cpp set softtabstop=2
autocmd FileType c,cpp set shiftwidth=2
autocmd FileType c,cpp setlocal commentstring=//%s
autocmd TermOpen * IndentBlanklineDisable
set expandtab
" syntax on " This causes issue with diagnostics for some reason
set undodir=~/.local/share/nvim/undodir
set undofile
set colorcolumn=80
set nohlsearch
set ignorecase
set smartcase
set number relativenumber
set nu rnu
set nowrap
set showmatch
set incsearch
set noshowmode
set wildmenu
set errorformat=%A%f:%l:%c:%m,%-G%.%# " Error format for quickfix
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
set t_Co=256
colorscheme zephyr
set mouse=a

let g:vimsyn_embed = 'lP'
let g:python_highlight_all = 1
let g:python3_host_prog = '~/python_venvs/nvim/bin/python3'
if executable('rg')
    let g:rg_derive_root='true'
endif

"Rebinds
let mapleader=' '
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
nmap ; <Plug>Sneak_;
nmap , <Plug>Sneak_,
vmap ; <Plug>Sneak_;
vmap , <Plug>Sneak_,
xmap <leader>s <Plug>Sneak_s
xmap <leader>S <Plug>Sneak_S
omap <leader>s <Plug>Sneak_s
omap <leader>S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

inoremap jk <esc>
nnoremap <leader>c :nohlsearch<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap <silent><leader>u :UndotreeToggle<CR>
nnoremap <leader><bar> :vsp<CR>
nnoremap <leader>- :sp<CR>

" nnoremap <silent><leader>e :NvimTreeToggle<cr>

nnoremap <leader>m :MaximizerToggle!<CR>

nnoremap <leader>dc :lua require'dap'.continue()<cr>
nnoremap <leader>dj :lua require'dap'.step_over()<cr>
nnoremap <leader>dl :lua require'dap'.step_into()<cr>
nnoremap <leader>dh :lua require'dap'.step_out()<cr>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>dbc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <leader>dd :call vimspector#Launch()<CR>
" nnoremap <leader>de :call vimspector#Reset()<CR>
" nnoremap <leader>dl <Plug>VimspectorStepInto
" nnoremap <leader>dj <Plug>VimspectorStepOver
" nnoremap <leader>dh <Plug>VimspectorStepOut
" nnoremap <leader>dr <Plug>VimspectorRestart
" nnoremap <leader>dc :call vimspector#Continue()<CR>
" nnoremap <leader>drc <Plug>VimspectorRunToCursor
" nnoremap <leader>dbt <Plug>VimspectorToggleBreakpoint
" nnoremap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

nnoremap <silent><leader>ff :Telescope find_files<cr>
nnoremap <silent><leader>fg :Telescope live_grep<cr>
nnoremap <silent><leader>fb :Telescope buffers<cr>
nnoremap <silent><leader>fm :Telescope marks<cr>
nnoremap <silent><leader>fq :Telescope quickfix<cr>
nnoremap <silent><leader>fl :Telescope loclist<cr>
nnoremap <silent><leader>gc :Telescope git_commits<cr>
nnoremap <silent><leader>gb :Telescope git_branches<cr>
nnoremap <silent><leader>gs :Telescope git_status<cr>

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <silent><leader>hs :Gitsigns stage_hunk<cr>
nnoremap <silent><leader>hu :Gitsigns undo_stage_hunk<cr>
nnoremap <silent><leader>hr :Gitsigns reset_hunk<cr>
nnoremap <silent><leader>hR :Gitsigns reset_buffer<cr>
nnoremap <silent><leader>hb :Gitsigns blame_line<cr>
nnoremap <silent><leader>hp :Gitsigns preview_hunk<cr>
nnoremap ]h :Gitsigns next_hunk<cr>
nnoremap [h :Gitsigns prev_hunk<cr>

nnoremap <silent> gf :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> <leader>e :Lspsaga show_line_diagnostics<CR>
nnoremap <silent> ]d :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> [d :Lspsaga diagnostic_jump_prev<CR>

function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    botright copen 7
endfunction

nnoremap <silent><leader>qf :call QuickFix_toggle()<cr>
nnoremap <silent>]q :cnext<cr>
nnoremap <silent>[q :cprevious<cr>
nnoremap <silent><leader>qn :cnext<cr>
nnoremap <silent><leader>qp :cprevious<cr>
nnoremap <silent><leader>qc :cc<cr>

function! s:BlameToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitiveblame'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git blame
  endif
endfunction

nnoremap <silent><leader>gd :Gdiff<cr>

let g:sneak#use_ic_scs = 1

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_syntax_conceal_default=0

let g:peekup_paste_before = '<leader>P'
let g:peekup_paste_after = '<leader>p'

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments']
let g:indent_blankline_char = '▏'

let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-bash-debug' ]

" Highlight TODO, FIXME, NOTE, etc.
augroup todo
    autocmd!
    autocmd Syntax * call matchadd(
                \ 'Debug',
                \ '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|BUG|HACK)>'
                \ )
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
