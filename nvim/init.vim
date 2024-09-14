lua require('config')

" ---------------------------------------------------------------------------
set scrolloff=10
" drop vi support - kept for vim compatibility but not needed for nvim
" Probably not needed with Vim 8+
set nocompatible

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" use Unicode
set encoding=utf-8

" errors flash screen rather than emit beep
set visualbell

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
set relativenumber 
set number 

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=4 shiftwidth=4 softtabstop=4 

" Indent new line the same as the preceding line
set autoindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" for linux
set clipboard=unnamedplus

"Ctrl+Shift+up move line above"
nmap <C-S-Up> :m -2<CR>

"Ctrl+Shift+down move line below
nmap <C-S-Down> :m +1<CR>

let g:zig_fmt_parse_errors=0
