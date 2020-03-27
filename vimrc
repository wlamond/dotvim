set nocompatible
set shell=/bin/bash

let vundle_autoinstall = 0
let vundle_readme = expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let vundle_autoinstall = 1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-airline/vim-airline'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'gnupg'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on

"
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" fix indent and color stuff...
set term=screen-256color
set t_Co=256
colorscheme zenburn

set hlsearch
set smartindent
set shiftwidth=2
set expandtab
set tabstop=2
set number
set mouse=a
set list
set scrolloff=5
set ignorecase smartcase
set incsearch
set directory^=$HOME/tmp
set laststatus=2
set timeoutlen=1000 ttimeoutlen=0
set backspace=indent,eol,start

syntax on

let &t_AB="\e[48;5;%dm"

" set up some keybinds...
let mapleader = ","
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
map <Leader>v <esc>:-tabmove<CR>
map <Leader>b <esc>:+tabmove<CR>
noremap <Leader>y "*y

" ALE keybinds
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

" remap the window switch functions. C-J since C-j is tmux's prefix.
map <c-m> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

nmap <F8> :TagbarToggle<CR>

map <Leader>s :set spell spelllang=en_us<CR>

vnoremap < <gv
vnoremap > >gv

if vundle_autoinstall
  echo "Installing bundles..."
  echo ""
  :PluginInstall
endif

let g:ctrlp_map = '<leader>f'
nmap <Leader>J <Esc><C-]>
let g:ctrlp_user_command = "find %s -type f -not -wholename '*.svn*' " .
                         \ "-not -iname '*.jpg' " .
                         \ "-not -iname '*.gif' " .
                         \ "-not -iname '*.pdf' " .
                         \ "-not -iname '*.png' " .
                         \ "| sort -d"
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$|\.svn$',
    \ 'file': '\.so$|\.dat$|\.DS_Store$|Thumbs.db|\.pdf$|\.jpg$|\.png$|\.ttf$|\.gif$'
\ }
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_extensions = ['funky']

nnoremap <Leader>g :CtrlPFunky<Cr>

let g:tagbar_type_php  = {
  \ 'ctagstype' : 'php',
  \ 'kinds'     : [
    \ 'i:interfaces',
    \ 'c:classes',
    \ 'd:constant_definitions',
    \ 'f:functions'
  \ ]
\ }

"let g:syntastic_php_checkers = ['phpcs']

let g:GPGDefaultRecipients = ['Will Lamond']

nnoremap K <Nop>

autocmd BufWritePre *.php :%s/[\r \t]\+$//e
autocmd BufWritePre *.py :%s/[\r \t]\+$//e
autocmd BufWritePre *.js :%s/[\r \t]\+$//e
autocmd BufWritePre * :%s/[\r \t]\+$//e
autocmd BufWritePost .vimrc :so ~/.vimrc
autocmd FileType python set expandtab ts=4 sw=4 textwidth=119 colorcolumn=120
highlight ColorColumn ctermbg=0

" turn hybrid line numbers on
set number relativenumber
