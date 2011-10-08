set nocompatible
set background=dark

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile js*  set textwidth=80
au FileType java let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

set backspace=indent,eol,start

set spell
set ruler nu 
set showcmd hlsearch incsearch noerrorbells
set list

set wildmode=longest:full
set wildmenu

set tags=./tags,tags
filetype plugin indent on
set mouse=a

set cursorline cursorcolumn

runtime! macros/matchit.vim

execute "set listchars=tab:" . nr2char(187) . '\ '

set foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1 

if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0 
  set guioptions-=T
  colorscheme ir_black
  set clipboard+=unnamed
endif

set nobackup nowritebackup noswapfile

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype off
syntax on
filetype plugin indent on

if v:version >= 700
  set colorcolumn=+1
  hi ColorColumn guibg=#2d2d2d ctermbg=246
endif

