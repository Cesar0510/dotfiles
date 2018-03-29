set number
set bs=2
set ts=4
set nocompatible
set laststatus=2     
highlight ColorColumn ctermbg=gray
set colorcolumn=120
set t_Co=256
set nocompatible              " be iMproved, required
filetype off                  " required
set directory=$HOME/.vim/swapfiles/
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
" All of your Plugins must be added before the following line
"
"


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
"{cmd} {attr} {lhs} {rhs}
"
"where
"{cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
"       ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
"{attr} is optional and one or more of the following: <buffer>, <silent>,
"       <expr> <script>, <unique> and <special>.
"       More than one attribute can be specified to a map.
"{lhs}  left hand side, is a sequence of one or more keys that you will use
"       in your new shortcut.
"{rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
"       will execute when entered.
map <C-n> :NERDTreeToggle<CR>
