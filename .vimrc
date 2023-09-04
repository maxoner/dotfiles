filetype off                  " required
set number
set nocompatible              " be iMproved, required
set noswapfile
set backspace=indent,eol,start
set expandtab
set tabstop=4
set splitbelow
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'sonph/onehalf', {'rtp': 'vim/'}

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vimwiki/vimwiki'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'rust-lang/rust.vim'
Plugin 'michal-h21/vim-zettel'
Plugin 'neovimhaskell/haskell-vim'
"Plugin 'monkoose/fzf-hoogle.vim'
"Plugin 'idris-hackers/idris-vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/goyo.vim'
Plugin 'godlygeek/tabular'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-surround'

Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"let g:netrw_keepdir=0
"nnoremap gx :!open <cWORD> &<CR><CR>
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
if !exists("g:syntax_on")
    syntax enable
endif
color gruvbox
let g:gruvbox_italic=1
hi Normal ctermbg=NONE

let g:vim_markdown_fenced_languages = ['csharp=cs', 'python=py']

func! s:lsp_mappings()
    nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
endfunc


augroup LSP | au!
    autocmd FileType go,json,yaml call s:lsp_mappings()
augroup END
