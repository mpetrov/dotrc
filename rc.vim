" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
" set textwidth=120       " break lines when line length increases
set tabstop=2           " use 4 spaces to represent tab
set softtabstop=2
set shiftwidth=2        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler                           " show line and column number
syntax on                       " syntax highlighting
set showcmd                     " show (partial) command in status line

set tags=./tags,tags
set nocompatible
syntax on
filetype plugin indent on
au BufNewFile,BufRead *.r,*.R set filetype=r
set mouse=a

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
runtime! macros/matchit.vim

set hls
set list
set nu
set listchars=
execute "set listchars+=tab:" . nr2char(187) . '\ '
set backupskip=/tmp/*,/private/tmp/*"
set nofoldenable
set smartindent

set tags=tags;/

" Enable ir_black for guis or 256 colour terms
if has('gui') || &t_Co == 256
     "set columns=80 
endif

if has('gui_macvim')
     set guifont=Menlo:h11
     set transparency=0 " (opaque) 0-100 (transparent)
     set guioptions-=T " hide toolbar
endif


autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab " Ruby

" don't create backup grabage
set nobackup
set nowritebackup
set noswapfile


autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

"let Tlist_javascript_Ctags_Cmd = '~/.vim/closure_ctags.rb'

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

let g:SuperTabDefaultCompletionType = "<c-n>"

if has("gui_macvim")
  colorscheme ir_black
endif

filetype off
syntax on
filetype plugin indent on



set textwidth=80
set colorcolumn=+1

hi ColorColumn guibg=#2d2d2d ctermbg=246

set hlsearch
set spell
