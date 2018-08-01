" Load all plugins
execute pathogen#infect()

:let mapleader = ","

set nocompatible
set hidden

if has("gui_running")
    set guioptions-=T "remove toolbar
    set guioptions-=m "remove menu bar
    set guioptions-=r "remove right scroll
    set guioptions-=L "remove left scroll
endif

" Set utf8 as standard encoding and en_US as the standard language
set anti enc=utf-8

set guifont=Source_Code_Pro:h11

" Set type of files
filetype on
filetype indent on
filetype plugin on

" Search settings
set ignorecase
set hlsearch
set incsearch
set smartcase

" General settgins
syntax enable
set number
set fileencoding=utf-8
set tabline=0
set encoding=utf-8
set backspace=indent,eol,start
set ts=4 sts=4 sw=4 expandtab
set scrolloff=5
set columns=150
set smarttab
set wrap
set linebreak
set autoindent
set smartcase
set showcmd
set cursorline
set splitbelow
set splitright

" Turn backup off
set nobackup
set nowb
set noswapfile

" Mappings
imap jj <ESC>

nmap B ^
nmap E g_
nmap dB d^
nmap dE d$
nmap <silent><ESC><ESC> :noh<CR>

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

map <C-n> :NERDTreeToggle<CR>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Auto commands
autocmd BufRead,BufNewFile *.xaml set filetype=xml
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Go commands
let g:go_fmt_autosave = 0
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

"color scheme
try
colorscheme base16-eighties
catch
endtry

set wildmenu

" CtrlP setup
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'r'

set wildignore+=*\\tmp\\*,*\\node_modules\\*,*.swp,*.zip,*.exe

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]((\.(git|hg|svn))|node_modules)',
  \ 'file': '\v\.(exe|dll)$'
  \ }

" NERDTree setup
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoDeleteBuffer = 1

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

if has("gui_running")
    " Incsearch setup
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif
