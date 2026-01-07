lua require('plugins')
filetype plugin on
set completeopt=menu,menuone,noselect
set hidden
set updatetime=1000
set signcolumn=auto
set listchars=tab:\ \ ,eol:
set timeoutlen=1000
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set autoindent
set cindent
set expandtab
syntax on
set undodir=~/.local/share/nvim/undodir
set undofile
set colorcolumn=120
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
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set nofoldenable                     " Disable folding at startup.
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
set t_Co=256
colorscheme tokyonight
set mouse=a

let g:vimsyn_embed = 'lP'
let g:python_highlight_all = 1
if executable('rg')
    let g:rg_derive_root='true'
endif

"Rebinds
let mapleader=' '

inoremap jk <esc>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>
noremap <silent> <m-h> :TmuxNavigateLeft<cr>
noremap <silent> <m-j> :TmuxNavigateDown<cr>
noremap <silent> <m-k> :TmuxNavigateUp<cr>
noremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap <silent><leader>u :UndotreeToggle<CR>
nnoremap <leader><bar> :vsp<CR>
nnoremap <leader>- :sp<CR>

nmap <Plug>Run :lua require'dap'.run_to_cursor()<cr>
            \ :call repeat#set("\<Plug>RunToCursor")<CR>
            \ :echo "Run to cursor"<CR>
nmap <Plug>Continue :lua require'dap'.continue()<cr>
            \ :call repeat#set("\<Plug>Continue")<CR>
            \ :echo "Continue"<CR>
nmap <Plug>StepOver :lua require'dap'.step_over()<cr>
            \ :call repeat#set("\<Plug>StepOver")<CR>
            \ :echo "Step over"<CR>
nmap <Plug>StepInto :lua require'dap'.step_into()<cr>
            \ :call repeat#set("\<Plug>StepInto")<CR>
            \ :echo "Step into"<CR>
nmap <Plug>StepOut  :lua require'dap'.step_out()<cr>
            \ :call repeat#set("\<Plug>StepOut")<CR>
            \ :echo "Step out"<CR>
nmap <Plug>Breakpoint :lua require'dap'.toggle_breakpoint()<cr>
            \ :call repeat#set("\<Plug>Breakpoint")<CR>
            \ :echo "Toggle breakpoint"<CR>
nmap <leader>dc <Plug>Continue
nmap <leader>dj <Plug>StepOver              
nmap <leader>dl <Plug>StepInto              
nmap <leader>dh <Plug>StepOut               
nmap <leader>db <Plug>Breakpoint            
nmap <leader>dr <Plug>RunToCursor
nnoremap <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent><leader>de :lua require("dapui").eval()<CR>
nnoremap <silent><leader>dt :lua require("dapui").toggle()<CR>

nnoremap <silent><leader>ff :FzfLua files<cr>
nnoremap <silent><leader>fg :FzfLua live_grep<cr>
nnoremap <silent><leader>fb :FzfLua buffers<cr>
nnoremap <silent><leader>fq :FzfLua quickfix<cr>
nnoremap <silent><leader>ft :TodoFzfLua<cr>
nnoremap <silent><leader>gc :FzfLua git_commits<cr>
nnoremap <silent><leader>gb :FzfLua git_branches<cr>
nnoremap <silent><leader>gs :FzfLua git_status<cr>
nnoremap <silent><leader>fr :FzfLua resume<cr>
nnoremap gD :FzfLua lsp_definitions<cr>
nnoremap gi :FzfLua lsp_implementations<cr>
nnoremap <leader>D :FzfLua lsp_typedefs<cr>
nnoremap gr :FzfLua lsp_references<cr>

nnoremap <silent><leader>gd :Gdiff<cr>

nnoremap <silent><leader>hs :Gitsigns stage_hunk<cr>
nnoremap <silent><leader>hu :Gitsigns undo_stage_hunk<cr>
nnoremap <silent><leader>hr :Gitsigns reset_hunk<cr>
nnoremap <silent><leader>hR :Gitsigns reset_buffer<cr>
nnoremap <silent><leader>hb :Gitsigns blame_line<cr>
nnoremap <silent><leader>hp :Gitsigns preview_hunk<cr>
nnoremap ]h :Gitsigns next_hunk<cr>
nnoremap [h :Gitsigns prev_hunk<cr>

nnoremap <silent>gf :Lspsaga finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :Lspsaga code_action<CR>
nnoremap <silent><leader>cr :Lspsaga rename<CR>
nnoremap <silent>gd :Lspsaga peek_definition<CR>
nnoremap <silent><leader>e :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>cd :Lspsaga show_cursor_diagnostics<CR>
nnoremap <silent>[e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>]e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent><leader>o :Lspsaga outline<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>

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

nnoremap <silent><leader>gfs :Git<cr>
nnoremap <silent><leader>gfd :Git difftool<cr>
nnoremap <silent><leader>gfm :Git mergetool<cr>
nnoremap <silent><leader>gfv :Gvdiffsplit<cr>

nnoremap <leader>cf :lua vim.lsp.buf.format()<cr>

function! BlameToggle()
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

let g:vimtex_view_method = 'zathura'

let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
augroup END

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
lua require('setup')
