" Set some plugin preferences {{{1
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
let g:EclimLoggingDisabled = 1
let g:syntastic_java_checkers = []
let g:EclimCompletionMethod = 'omnifunc'

" Bootstrap and load Vundle plugins {{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'airblade/vim-gitgutter'
Bundle 'chrisbra/NrrwRgn'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ZoomWin'
Bundle 'argtextobj.vim'
Bundle 'ervandew/supertab'
Bundle 'garyharan/vim-proto'
Bundle 'gmarik/vundle'
Bundle 'guns/xterm-color-table.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'sjl/vitality.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/keepcase.vim'
Bundle 'vim-scripts/tComment'
Bundle 'duganchen/vim-soy'
Bundle 'scrooloose/syntastic'
Bundle 'nelstrom/vim-visual-star-search'

Bundle 'git@github.com:mpetrov/vim-ctrlp-related.git'
Bundle 'git@github.com:mpetrov/vim-diffstat.git'
filetype plugin indent on

runtime! ftplugin/man.vim

" Aesthetics{{{1
" MacVIM / GVim settings {{{2
if has('gui_running')
  set guioptions=egmt
endif

" If we're using MacVim
if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0
endif

" Assume a 256 colour terminal, make it pretty {{{2
set background=dark t_Co=256
colorscheme wombat256
execute "set listchars=tab:" . nr2char(187) . '\ '
set ruler nu hls
set showcmd noerrorbells list wildmenu

" General Settings  {{{1

" Encoding and file preferences
set encoding=utf8 fileformats=unix,dos,mac

" Status and command settings
set laststatus=2 history=1000

" Undo and backup settings
set nobackup nowritebackup noswapfile
set updatecount=0

" Spelling options
set spelllang=en_gb nospell

" Menu options
set wildmode=list:longest,full

" Enable the mouse
set mouse=a

" CTags files
set tags=./tags,tags
runtime! macros/matchit.vim

" Ignore some files when using ctrl-p
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,*.pyc,gen,bin,*.class,*~,*.Po,*.git5_specs

" Fold options
set foldmethod=indent foldnestmax=10 foldenable foldlevelstart=4

" Hide the eclim sratch window
" set completeopt-=preview

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

" Share the clipboard and use colorcolumn on vim 7.3 {{{2
if v:version >= 703
  set colorcolumn=+1
  hi ColorColumn ctermbg=236 cterm=none guibg=#2d2d2d
  set clipboard+=unnamed
endif

" Keyboard mappings {{{1
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>l "qyiwgv:s/\<<C-r>q\>//g<Left><Left>
nnoremap <Leader>L "qyiwgv:s/\<<C-r>q\>/<C-r>q/g<Left><Left>
nnoremap <Leader>a "ayiw:Ack <C-r>a<CR>

nmap <leader><left>  :9wincmd <<cr>
nmap <leader><right> :9wincmd ><cr>
nmap <leader><up>    :9wincmd +<cr>
nmap <leader><down>  :9wincmd -<cr>

noremap <silent> <leader>gs :Gstatus<CR>
noremap <silent> <leader>gc :Gcommit -a<CR>
noremap <silent> <leader>gd :Gdiff<CR>
noremap <silent> <leader>s :set spell!<CR>
noremap <silent> <leader>p :set paste!<CR>
noremap <silent> <leader>h :set hls!<CR>
noremap <silent> <leader>m :w<ENTER>:make<CR>
noremap <silent> <leader>n :NERDTreeToggle<CR>
noremap <silent> <leader>f :NERDTreeFind<CR>
noremap <silent> <leader>g :GundoToggle<CR>

noremap <leader>d :DiffStat HEAD HEAD..HEAD~1 HEAD~1..HEAD~2<cr>

nnoremap <Leader>cc :CtrlPClearAllCaches<CR>:CtrlP<CR>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>t :TagbarToggle<cr>
noremap <C-h> :CtrlPMRU<cr>


function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
    setlocal nonu
  else
    setlocal colorcolumn=+1
    setlocal nu
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

" Define some mappings and indentation for Java
function! s:JavaBufferSettings()
  IndentLevel 2
  setlocal textwidth=100
  setlocal cinoptions-=(0
  setlocal spell

  " Eclim bindings
  nnoremap <buffer> <LocalLeader>c :JavaCorrect<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>f :JavaContextSearch<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>con :JavaConstructor<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>gg :JavaGet<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>gs :JavaGetSet<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>i :JavaImportOrganize<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>pp :ProjectProblems!<CR> :redraw!<CR>
  nnoremap <buffer> <LocalLeader>r :JavaRename
  nnoremap <buffer> <LocalLeader>ss :JavaSet<CR> :redraw!<CR>

  setlocal completefunc=eclim#java#complete#CodeComplete
endfunction

augroup mpetrovgroup
  autocmd!

  autocmd BufRead,BufNewFile *.tex  setlocal iskeyword+=_
  autocmd BufRead,BufNewFile *.srcjar setlocal ft=tar
  autocmd BufReadCmd *.srcjar call zip#Browse(expand("<amatch>"))

  autocmd FileType c IndentLevel 4
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType cpp IndentLevel 4
  autocmd FileType java call s:JavaBufferSettings()
  autocmd FileType javascript IndentLevel 2
  autocmd FileType man setlocal nolist
  autocmd FileType make setlocal noexpandtab
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

" Utilitiy functions {{{1
function! g:DiffTestOutput()
    norm "ayy
    new
    norm "ap
    %s/but was/\r/g
    norm gg"addG"add
    %s/,/,\r/g
    diffthis
    vne
    norm "apgg"add
    %s/,/,\r/g
    diffthis
    diffu
endfunction


" Google specific stuff goes here {{{1
let g:google_vimrc = expand("~/.google_rc/google_rc.vim")
if filereadable(g:google_vimrc) && system('uname') =~? 'linux'
  exec "source " . g:google_vimrc
end

set formatoptions+=j
