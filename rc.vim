set nocompatible

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

set autoindent smartindent cindent

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile js*  set textwidth=80
au FileType java let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete


" make backspaces more powerfull
set backspace=indent,eol,start

set spell

set ruler nu 
set showcmd hlsearch 
set list

set tags=./tags,tags
syntax on
filetype plugin indent on
set mouse=a

let g:SuperTabDefaultCompletionType = "<c-n>"
runtime! macros/matchit.vim

set listchars=
execute "set listchars+=tab:" . nr2char(187) . '\ '

set  foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1 

if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0 
  set guioptions-=T
  colorscheme ir_black
endif

set nobackup nowritebackup noswapfile

"let Tlist_javascript_Ctags_Cmd = '~/.vim/closure_ctags.rb'

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype off
syntax on
filetype plugin indent on

if v:version >= 700
  set colorcolumn=+1
  hi ColorColumn guibg=#2d2d2d ctermbg=246
endif

