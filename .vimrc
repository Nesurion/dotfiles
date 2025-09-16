call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'nordtheme/vim'
Plug 'ryanoasis/vim-devicons'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" highlight copied text
Plug 'machakann/vim-highlightedyank'
" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" commentary plugin
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/argtextobj.vim'
Plug 'dbakker/vim-paragraph-motion'
" Plug 'preservim/nerdtree'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

call plug#end()

let mapleader=" "
let maplocalleader="\\"

:set encoding=UTF-8
:set clipboard=unnamedplus
set rtp+=/opt/homebrew/opt/fzf
" Autowrite buffer when switching between buffers
set autowrite
set completeopt=menu,menuone,noselect
" Hide * markup for bold and italic, but not markers with substitutions
set conceallevel=2
" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5
" Confirm to save changes before exiting modified buffer
set confirm
" Enable highlighting of the current line
set cursorline
" Use spaces instead of tabs
set expandtab
set foldlevel=99
set formatoptions=jcroqlnt " tcqj
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
" Preview incremental substitute
" set inccommand=nosplit
" set jumpoptions=view
" Global statusline
set laststatus=3
" Wrap lines at convenient points
set linebreak
" Show some invisible characters (tabs...)
set list
" Enable mouse mode
set mouse=a
" Print line number
set number
" Popup blend
" set pumblend=10
" Maximum number of entries in a popup
set pumheight=10
" Do incremental searching.
set incsearch
" Search case insensitive
set ignorecase
" Use case sensitive search when at least one char is uppercase
set smartcase
" Highlight search results
set hlsearch
" Highlight search results as you type
" set highlightedyank
" disable the timeout option
set notimeout
" increase the timeoutlen (default: 1000)
set timeoutlen=5000
" Insert indents automatically
set smartindent
set spelllang=en
" Enable undo file
set undofile
set undolevels=10000
" True color support
set termguicolors
" Visual bell instead of beeping
set visualbell
" Enable which-key
" set which-key
" Disable line wrap
set nowrap
" Allow cursor to move where there is no text in visual block mode
set virtualedit=block

"" Keymaps
"" Search history
" Escape and Clear hlsearch
nmap <esc> :nohlsearch<CR>
"" Save File
inoremap <C-s> <C-o>:w<CR>
"" Window split
" Split Window Below
nmap <leader>- :split<CR>
" Split Window Right
nmap <leader>\ :vsplit<CR>

nnoremap <SPACE> <Nop>

nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Change c so that content is sent to blackhole register. This enables the,
" copy from somewhere, replace this with the clipboard content use case.
nnoremap c "_c
nnoremap C "_C

" Yank the content of the line without leading whitespace and linebreak
nnoremap <leader>yy ^v$hy

" Replace word under cursor with register content
nnoremap <leader>p viw"_dP
" nnoremap <leader>p "zdiW"+p

