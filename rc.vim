set nocompatible
set background=dark


" Fix the mouse in tmux.
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif


set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

let g:Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_javascript_Ctags_Cmd = '~/.vim/closure_ctags.rb'
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '~/.vim/closure_ctags.rb'
\ }


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

if getwinvar(0, '&diff')
  finish
endif

let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab

" Settings updated for libdwarf
au BufRead,BufNewFile *.c set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
au BufRead,BufNewFile *.h set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.js  set textwidth=80
au BufRead,BufNewFile *.js  setlocal iskeyword+=.

au BufRead,BufNewFile *.tex  setlocal iskeyword+=_


autocmd bufwritepost .vimrc source $MYVIMRC " auto-source .vimrc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
  
" au FileType java let g:SuperTabDefaultCompletionType = "<C-X, C-U>"

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" Ignore useless files from command-t searches
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,tools,gen,bin

set backspace=indent,eol,start

set spelllang=en_gb
set nospell
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
  set guioptions-=L
  set guioptions-=l
  set guioptions-=r
  set guioptions-=R
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

set fileformats=unix,dos,mac

set clipboard=unnamed

set history=1000


" Leader key mappings
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>m :w<ENTER>:make<CR>
nmap <silent> <leader>f :w<ENTER>:!fixjsstyle %<ENTER>:e! %<CR>

" Indent/unindent
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Tab switching for MacVim
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
    echo "Mouse usage disabled"
  else
    set mouse=a
    set number
    echo "Mouse usage enabled"
  endif
endfunction

"imap <tab> <Plug>SuperTabForward
"imap <s-tab> <Plug>SuperTabBackward

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
