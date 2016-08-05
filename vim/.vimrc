"Author: David Lee
"Email: kenbinglee@gmail.com
"LastUpdate: 2014/11/12


" Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-commentary'

"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Basic
set number
set nobackup
set background=dark
"set nocompatible
set incsearch hlsearch
set ignorecase smartcase
set whichwrap=b,s,h,l,<,>,[,]
set backspace=2
set matchtime=2
set history=100
set ambiwidth=double
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
syntax on
set completeopt-=preview
set list
set listchars=tab:>-


" Status & cmd related
set ruler
set statusline=%<%h%m%r\ %f%=[%{&filetype},%{&fileencoding},%{&fileformat}]%k\ %-14.(%l/%L,%c%V%)\ %P
set laststatus=2
set wildmenu
set showmode
set showcmd


" Tab related
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab


" Cursor color related
" silent !echo -ne "\033]12;RoyalBlue1\007" 
" let &t_SI = "\<esc>]12;green\007"
" let &t_EI = "\<esc>]12;RoyalBlue1\007"
" autocmd Vimleave * silent !echo -ne "\033]12;Gray90\007"
if &term =~ '^xterm'
    " solid underscore
    let &t_SI .= "\<Esc>[6 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif


" Wrap related
set nowrap
set linebreak
set formatoptions+=mB
au BufRead,BufNewFile *.md setlocal textwidth=88


" Key mapping
imap <C-f> <Right>
cmap <C-f> <Right>
imap <C-b> <Left>
cmap <C-b> <Left>
imap <C-a> <ESC>^i
cmap <C-a> <HOME>
imap <C-e> <END>
cmap <C-e> <END>

cmap <C-p> <UP>
cmap <C-n> <DOWN>

imap <C-d> <Del>
cmap <C-d> <Del>

nmap <C-p> :bNext<CR>
nmap <C-n> :bnext<CR>

map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" Easily to draw a boundary
iabbrev #b *************************************************


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 88 characters.
  autocmd FileType text setlocal textwidth=88

  " Commentary
  " autocmd FileType python,shell,coffee set commentstring=#\ %s
  " autocmd FileType php,c,cpp,java set commentstring=//\ %s
  
  " Test line  
  " autocmd FileType text set nu

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" ************************************************* Plugins *************************************************

" Ctags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Tagbar
nmap <F10> :TagbarToggle<CR>

" NerdTree
nmap <F2> :NERDTreeToggle<CR>

" MiniBufExpl
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0  

" Ack
"nmap <C-S-f> :Ack 

" Doxygen
let g:DoxygenToolkit_briefTag_pre="@Synopsis "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns "
let g:DoxygenToolkit_authorName="kb(kenbinglee@gmail.com)"

" Ctrlp
let g:ctrlp_map = '<C-f>'

" EasyMotion
let g:EasyMotion_leader_key='<Space>'

" Commentary
let g:commentstring="//\ %s"

" fugitive 
nmap gb :Gblame<CR>   
