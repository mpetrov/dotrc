set nocompatible
set encoding=utf-8
set laststatus=2

" Set some plugin preferences
let g:ctrlp_working_path_mode = 0
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = {'BRANCH': '', 'LINE': ''}
let g:Powerline_dividers_override = ['', '|', '', '']

" Load Vundle plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'YankRing.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'msanders/snipmate.vim'
Bundle 'duganchen/vim-soy'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-unimpaired'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ack.vim'
Bundle 'tComment'
Bundle 'ZoomWin'
Bundle 'HiColors'
filetype on

set background=dark t_Co=256
colorscheme wombat256


if has('mouse') 
  set mouse=a
  autocmd VimEnter,FocusGained,BufEnter,InsertEnter,InsertLeave,CursorHold *
        \ set ttymouse=xterm2
endif


set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

let g:syntastic_disabled_filetypes = ["c", "html"]

set spelllang=en_gb nospell
set ruler nu 

let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile Makefile* set noexpandtab

au BufRead,BufNewFile *.c set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
au BufRead,BufNewFile *.cc set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
au BufRead,BufNewFile *.h set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

au BufRead,BufNewFile *.js  setlocal iskeyword+=.
au BufRead,BufNewFile *.tex  setlocal iskeyword+=_

set textwidth=80

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Ignore useless files from command-t searches
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,tools,gen,bin,*.class,*~,*.Po

set backspace=indent,eol,start
set spelllang=en_gb
set showcmd incsearch noerrorbells list wildmenu
set nospell nu hls
set wildmode=list:longest,full

set tags=./tags,tags
filetype plugin indent on

runtime! macros/matchit.vim

execute "set listchars=tab:" . nr2char(187) . '\ '

set foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1 

if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0 
  set guioptions=egmt 
endif

cmap w!! w !sudo tee % >/dev/null

set nobackup nowritebackup noswapfile

filetype off
syntax on
filetype plugin indent on

if v:version >= 703
  set colorcolumn=+1
  hi ColorColumn ctermbg=236 cterm=none guibg=#2d2d2d
  set clipboard+=unnamed
endif

set fileformats=unix,dos,mac
set history=1000

" Leader key mappings
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>p :set paste!<CR>
nmap <silent> <leader>h :set hls!<CR>
nmap <silent> <leader>m :w<ENTER>:make<CR>
nmap <silent> <leader>f :w<ENTER>:!fixjsstyle %<ENTER>:e! %<CR>

noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" MacVim bindings.
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Hack for toggling mouse usage
nmap <silent> <leader>c :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    set nonumber
    sign unplace *
    echo "Mouse usage disabled"
  else
    set mouse=a
    set number
    set ttymouse=xterm2
    echo "Mouse usage enabled"
  endif
endfunction

function! s:pbcopy()
  call system("ssh localhost -p 6969 pbcopy", getreg(""))
endfunction
command! -nargs=0 -bar PBCopy call s:pbcopy()

function! s:pbpaste()
  call setreg("", system("ssh localhost -p 6969 pbpaste"))
endfunction
command! -nargs=0 -bar PBPaste call s:pbpaste()

set undofile undodir=~/.vim/undodir undolevels=1000  undoreload=10000 

