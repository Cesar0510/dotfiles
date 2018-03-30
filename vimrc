set number
set bs=2
set ts=4
set nocompatible
set laststatus=2     
"" highlight ColorColumn ctermbg=gray
set colorcolumn=120
set nocompatible              " be iMproved, required
filetype off                  " required

"################################"
set directory=$HOME/.vim/swapfiles/
set rtp+=/usr/lib/python3.6/site-packages/powerline/bindings/vim
"################################"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'


Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'altercation/vim-colors-solarized'

"" Plugin 'vim-airline/vim-airline'
"" Plugin 'vim-airline/vim-airline-themes'
"" Plugin 'leafgarland/typescript-vim'
"" Plugin 'pangloss/vim-javascript'


call vundle#end()            " required
filetype plugin indent on    " required


filetype plugin on
let g:powerline_pycmd="py3"
"#######################"

map <C-n> :NERDTreeToggle<CR>

"#######################"



