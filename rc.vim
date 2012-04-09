set nocompatible
set laststatus=2
set encoding=utf-8

let g:LustyJugglerSuppressRubyWarning = 1
let g:ctrlp_working_path_mode = 0
" Load Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'msanders/snipmate.vim'
Bundle 'duganchen/vim-soy'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-unimpaired'
Bundle 'kien/ctrlp.vim'
Bundle "git.zip"
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle "ack.vim"
Bundle "tComment"
Bundle "ZoomWin"
Bundle 'mutewinter/vim-indent-guides'
Bundle 'mutewinter/LustyJuggler'
Bundle 'HiColors'
filetype on
set background=dark
set t_Co=256
colorscheme wombat256


let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = {
        \ 'BRANCH': 'ψ',
        \ 'LINE': '↳',
        \ }


if has('mouse') 
  set mouse=a
"  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter * set ttymouse=xterm
    autocmd FocusGained * set ttymouse=xterm
    autocmd BufEnter * set ttymouse=xterm
"  endif
endif


set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

let g:Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_javascript_Ctags_Cmd = '~/.vim/closure_ctags.rb'
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '~/.vim/closure_ctags.rb'
\ }
let g:syntastic_disabled_filetypes = ["c", "html"]

let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '~/.vim/closure_ctags.rb',
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'o:objects',
        \ 'v:obj',
        \ 'f:functions',
        \ 'a:arrays',
        \ 's:strings'
    \ ]
\ }


set spelllang=en_gb
set nospell
set ruler nu 
set showcmd hlsearch incsearch noerrorbells
set list
set wildmode=longest:full
set wildmenu

let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile Makefile* set noexpandtab

au BufRead,BufNewFile *.c set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
au BufRead,BufNewFile *.h set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

au BufRead,BufNewFile *.js  set textwidth=80
au BufRead,BufNewFile *.js  setlocal iskeyword+=.
au BufRead,BufNewFile *.tex  setlocal iskeyword+=_


"autocmd bufwritepost .vimrc source $MYVIMRC

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
  

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Ignore useless files from command-t searches
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,tools,gen,bin,*.class

set backspace=indent,eol,start
set spelllang=en_gb
set showcmd hlsearch incsearch noerrorbells list wildmenu
set nospell nu
set wildmode=list:longest,full

set tags=./tags,tags
filetype plugin indent on

"set cursorline cursorcolumn

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

"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

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

set fileformats=unix,dos,mac
set clipboard=unnamed
set history=1000


" Leader key mappings
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>p :set paste!<CR>
nmap <silent> <leader>h :nohl<CR>
nmap <silent> <leader>m :w<ENTER>:make<CR>
nmap <silent> <leader>f :w<ENTER>:!fixjsstyle %<ENTER>:e! %<CR>

noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>
nnoremap <LocalLeader>/ :TComment<CR>
vnoremap <LocalLeader>/ :TComment<CR>
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
    echo "Mouse usage enabled"
  endif
endfunction

