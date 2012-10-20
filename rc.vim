set nocompatible

" Set some plugin preferences
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.git5_specs$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'blaze-bin\|blaze-genfiles\|blaze-google3\|blaze-out\|blaze-testlogs\|READONLY$',
  \ }
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = {'BRANCH': '', 'LINE': ''}
let g:Powerline_dividers_override = ['', '|', '', '']
let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = '<C-N>'

" Load Vundle plugins
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
Bundle 'vim-scripts/tComment'
Bundle 'ZoomWin'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mileszs/ack.vim'
Bundle 'garyharan/vim-proto'
filetype plugin indent on

let maplocalleader=","

" Encoding and file preferences
set encoding=utf8 fileformats=unix,dos,mac

" Status and command settings
set laststatus=2 history=1000

" Undo and backup settings
set undofile undodir=~/.vim/undodir undolevels=1000 undoreload=10000
set nobackup nowritebackup noswapfile

" If we're using a GUI vim
if has('gui_running')
  set guioptions=egmt
endif

" If we're using MacVim
if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0
  set guioptions=egmt
endif

" Text replacing and searching
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>l "qyiwgv:s/\<<C-r>q\>//g<Left><Left>
nnoremap <Leader>L "qyiwgv:s/\<<C-r>q\>/<C-r>q/g<Left><Left>
nnoremap <Leader>a "ayiw:Ack <C-r>a<CR>


nnoremap <Leader>cc :CtrlPClearAllCaches<CR>:CtrlP<CR>

" Indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
nmap <M-[> <<
nmap <M-]> >>
vmap <M-[> <gv
vmap <M-]> >gv

" Switch between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

noremap <C-m> :CtrlPMRU<cr>


" Shortcuts
noremap <silent> <leader>s :set spell!<CR>
noremap <silent> <leader>p :set paste!<CR>
noremap <silent> <leader>h :set hls!<CR>
noremap <silent> <leader>m :w<ENTER>:make<CR>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>t :CtrlPMRU<cr>

noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Commands
cmap w!! w !sudo tee % >/dev/null

" CTags files
set tags=./tags,tags
runtime! macros/matchit.vim

" Fold options
set foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1

" Indentation and tabbing
set autoindent smartindent cindent
function! s:IndentLevel(num)
  execute 'setlocal softtabstop=' . a:num . ' shiftwidth=' . a:num . ' expandtab'
endfunction
command! -nargs=* -bar IndentLevel call s:IndentLevel(<f-args>)
IndentLevel 2

" Assume a 256 colour terminal, make it pretty
set background=dark t_Co=256
syntax on
colorscheme wombat256
" execute "set listchars=tab:" . nr2char(187) . '\ '
set ruler nu hls
set showcmd noerrorbells list wildmenu

" Share the clipboard and use colorcolumn on vim 7.3
if v:version >= 703
  set colorcolumn=+1
  hi ColorColumn ctermbg=236 cterm=none guibg=#2d2d2d
  set clipboard+=unnamed
endif

" Spelling options
set spelllang=en_gb nospell

" Menu options
set backspace=indent,eol,start
set wildmode=list:longest,full


function! s:JavaBufferSettings()
  IndentLevel 2
  setlocal textwidth=100

  " Eclim bindings
  nnoremap <buffer> <LocalLeader>r :JavaRename
  nnoremap <buffer> <LocalLeader>c :JavaCorrect<CR>
  nnoremap <buffer> <LocalLeader>con :JavaConstructor<CR>
  nnoremap <buffer> <LocalLeader>gs :JavaGetSet<CR>
  nnoremap <buffer> <LocalLeader>g :JavaGet<CR>
  nnoremap <buffer> <LocalLeader>s :JavaSet<CR>
  nnoremap <buffer> <LocalLeader>ic :JavaImportClean<CR>
  nnoremap <buffer> <LocalLeader>im :JavaImportMissing<CR>
  nnoremap <buffer> <LocalLeader>pp :ProjectProblems<CR>
endfunction


" Some file-specific indentation rules
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.c IndentLevel 4
au BufRead,BufNewFile *.cc IndentLevel 4
au BufRead,BufNewFile *.h IndentLevel 4
au BufRead,BufNewFile *.tex  setlocal iskeyword+=_
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType java call s:JavaBufferSettings()

set mouse=a

" Ignore some files when using ctrl-p
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,*.pyc,gen,bin,*.class,*~,*.Po,*.git5_specs
set textwidth=80

" Open the buffer in the same spot
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Google specific stuff goes here:
let g:google_vimrc = "/home/mpetrov/.google_vimrc"
if filereadable(g:google_vimrc)
  exec "source " . g:google_vimrc
end
