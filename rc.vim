" Set some plugin preferences {{{1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'blaze-bin\|blaze-genfiles\|blaze-google3\|blaze-out\|blaze-testlogs\|READONLY$',
  \ }
let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = '<C-N>'
let g:airline_theme='wombat'
let g:airline_left_sep=''
let g:airline_right_sep=''

" Bootstrap and load Vundle plugins {{{1
call plug#begin()
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mpetrov/wombat256.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-pastie'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

" Aesthetics{{{1

" Assume a 256 colour terminal, make it pretty {{{2
set background=dark t_Co=256
colorscheme wombat256
set ruler nu hls showcmd noerrorbells list wildmenu

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" General Settings  {{{1

" Encoding and file preferences
set encoding=utf8 fileformats=unix,dos,mac

" Status and command settings
set laststatus=2 history=1000

" Undo and backup settings
set nobackup nowritebackup noswapfile updatecount=0
set backupdir=~/tmp
set undodir=~/tmp

" Spelling options
set spelllang=en_us nospell

" Menu options
set wildmode=list:longest,full

" Enable the mouse
set mouse=a

" Ignore some files when using ctrl-p
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,*.pyc,gen,bin,*.class,*~,*.Po

" Fold options
set foldmethod=indent foldnestmax=10 foldenable foldlevelstart=4

" Custom commands {{{2
cmap w!! w !sudo tee % >/dev/null

" Indentation and tabbing {{{2
set autoindent smartindent cindent
function! s:IndentLevel(num)
  execute 'setlocal softtabstop=' . a:num . ' shiftwidth=' . a:num . ' expandtab'
endfunction
command! -nargs=* -bar IndentLevel call s:IndentLevel(<f-args>)
IndentLevel 2

set textwidth=80

set colorcolumn=+1
set clipboard+=unnamed

" Keyboard mappings {{{1
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>l "qyiwgv:s/\<<C-r>q\>//g<Left><Left>
nnoremap <Leader>L "qyiwgv:s/\<<C-r>q\>/<C-r>q/g<Left><Left>

nmap <leader><left>  :9wincmd <<cr>
nmap <leader><right> :9wincmd ><cr>
nmap <leader><up>    :9wincmd +<cr>
nmap <leader><down>  :9wincmd -<cr>

noremap <silent> <leader>gs :Gstatus<CR>
noremap <silent> <leader>gc :Gcommit -a<CR>
noremap <silent> <leader>gd :Gdiff<CR>
noremap <silent> <leader>s :set spell!<CR>
noremap <silent> <leader>p :call g:TogglePaste()<CR>
noremap <silent> <leader>h :set hls!<CR>
noremap <silent> <leader>m :w<ENTER>:make<CR>
noremap <silent> <leader>n :NERDTreeToggle<CR>
noremap <silent> <leader>f :NERDTreeFind<CR>
noremap <silent> <leader>g :GundoToggle<CR>

nnoremap <Leader>cc :CtrlPClearAllCaches<CR>:CtrlP<CR>
" noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>t :TagbarToggle<cr>
noremap <C-h> :CtrlPMRU<cr>

function! g:TogglePaste()
  if &colorcolumn != ''
    setlocal colorcolumn&
    setlocal nonu
    set paste
  else
    setlocal colorcolumn=+1
    setlocal nu
    set nopaste
  endif
endfunction


" Indentation key mappings {{{2
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
nmap <M-[> <<
nmap <M-]> >>
vmap <M-[> <gv
vmap <M-]> >gv

vmap <M-m> :set mouse=<cr>set nonu<cr>

" File specific settings / local mappings {{{1

" Change the local leader key
let maplocalleader=","

augroup mpetrovgroup
  autocmd!

  autocmd BufRead,BufNewFile *.tex  setlocal iskeyword+=_
  autocmd BufRead,BufNewFile *.srcjar setlocal ft=tar
  autocmd BufReadCmd *.srcjar call zip#Browse(expand("<amatch>"))

  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType python setlocal spell
  autocmd FileType vim IndentLevel 2
  autocmd FileType vim setlocal foldmethod=marker foldlevel=0
  autocmd FileType zsh setlocal foldmethod=marker foldlevel=0

  " Open the buffer in the same spot
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Abberviations
abbrev todo TODO(mpetrov):

" Google specific stuff goes here {{{1
let g:google_vimrc = expand("~/google_rc/google_rc.vim")
if filereadable(g:google_vimrc)
  exec "source " . g:google_vimrc
end

set formatoptions+=j
