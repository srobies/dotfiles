lua require('init')
lua require('my_debug')

let g:sneak#use_ic_scs = 1
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_syntax_conceal_default=0
set timeoutlen=1000
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set autoindent
set cindent
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" C/Cpp specific tabsize
autocmd FileType c,cpp set tabstop=2
autocmd FileType c,cpp set softtabstop=2
autocmd FileType c,cpp set shiftwidth=2
autocmd FileType c,cpp setlocal commentstring=//%s
autocmd TermOpen * IndentBlanklineDisable
set expandtab
syntax on
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
nnoremap <leader>r :Rg<SPACE>
nnoremap <leader><bar> :vsp<CR>
nnoremap <leader>- :sp<CR>

nnoremap <silent><leader>e :NvimTreeToggle<cr>

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

nnoremap <silent><leader>ff :lua require('telescope').extensions.fzf_writer.files()<cr>
nnoremap <silent><leader>fg :Telescope live_grep<cr>
nnoremap <silent><leader>fb :Telescope buffers<cr>
nnoremap <silent><leader>fm :Telescope marks<cr>
nnoremap <silent><leader>fq :Telescope quickfix<cr>
nnoremap <silent><leader>fl :Telescope loclist<cr>
nnoremap <silent><leader>gc :Telescope git_commits<cr>
nnoremap <silent><leader>gb :Telescope git_branches<cr>
nnoremap <silent><leader>gs :Telescope git_status<cr>

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
nnoremap <silent><leader>gh :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>
nnoremap <silent><leader>gf :SignifyFold<cr>
nnoremap <silent><Leader>gb :call <SID>BlameToggle()<CR>
nnoremap <leader>gs :diffput<cr>

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
                \ '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|BUG|HACK|TRICKY)>'
                \ )
augroup END

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
" nnoremap <silent> <leader>e :call ToggleVExplorer()<CR>
let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 18
let g:netrw_banner = 0

"coc.nvim config
let g:coc_global_extensions = ['coc-snippets', 'coc-clangd', 'coc-pyright',
            \ 'coc-sh', 'coc-vimlsp', 'coc-lua', 'coc-vimtex',
            \ 'coc-discord-rpc']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

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
" nmap <leader>qf  <Plug>(coc-fix-current)
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

" Jumping to errors
nmap <leader>cn <Plug>(coc-diagnostic-next)
nmap <leader>cp <Plug>(coc-diagnostic-prev)
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

let g:coc_snippet_next = '<tab>'
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
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
