set nocompatible
set background=dark

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.js  set textwidth=80

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
  
"function! JavaOptions(...)
"  let g:SuperTabDefaultCompletionTypeDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
"  let g:SuperTabDefaultCompletionType = 'context'
"  let g:SuperTabLongestHighlight = 1
"endfunction

au FileType java let g:SuperTabDefaultCompletionType = "<C-X, C-U>"


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

"set cursorline cursorcolumn

runtime! macros/matchit.vim

execute "set listchars=tab:" . nr2char(187) . '\ '

set foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1 

set t_Co=256
colorscheme wombat256

if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0 
  set guioptions-=T
  set clipboard+=unnamed
  "colorscheme ir_black
endif

cmap w!! w !sudo tee % >/dev/null

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

if v:version >= 730
  set clipboard+=unnamed
endif
