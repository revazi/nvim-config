" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on
" syntax enable

set autoindent
set backspace=indent,eol,start

set foldenable                  " Auto fold code

set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
" set wildmenu wildmode=full

set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search

" highlight matches when searching
" Use C-l to clear (see key map section)
set hlsearch
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" scroll a bit horizontally when at the end of the line
set sidescroll=6

"disable showmode since using vim-airline; otherwise use 'set showmode'
set noshowmode

" enable line and column display
set ruler

" Line numbering
" Toggle set to ',n' in key map section
set nonumber

" Disable line wrapping
" Toggle set to ',w' in key map section
set nowrap

" Disable scrollbar in gui
" set scrolloff=9999
" hide right scrollbar
set guioptions-=r

" Fix E353: Nothing in register "
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" These are the basic settings to get the font to work (required):
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\:h12
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1
"

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

if has('statusline')
  " See also: autoload/settings.vim 802 version settings

  " Broken down into easily includeable segments
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options
  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set noswapfile 

" http://stackoverflow.com/questions/9001337/vim-split-bar-styling
set fillchars+=vert:\ 


" =====================================
" auto completion
" =====================================
set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt+=preview  " Enable the preview window

" Relax file compatibility restriction with original vi
" (not necessary to set with neovim, but useful for vim)
set nocompatible

" Disable beep / flash
set vb t_vb=

" replace tab with spaces
set expandtab

" allow cursor to move to beginning of tab
" will interfere with soft line wrapping (set nolist)
set list lcs=tab:\ \ 

"set completeopt+=noinsert
"set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1


" =====================================
" Go
" https://github.com/fatih/vim-go
" =====================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" markdown
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1


" go-def is automatically by default to plain "gd" (no leader required)
au FileType go nnoremap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gp <Plug>(go-def-pop)

au FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
" or open in a browser...
au FileType go nnoremap <Leader>gb <Plug>(go-doc-browser)

au FileType go nnoremap <Leader>s <Plug>(go-implements)
au FileType go nnoremap <Leader>i <Plug>(go-info)
au FileType go nnoremap <Leader>gl <Plug>(go-metalinter)
au FileType go nnoremap <Leader>gc <Plug>(go-callers)

" =====================================
" vim-airline status
" configure: https://github.com/vim-airline/vim-airline#user-content-extensible-pipeline
" =====================================
let g:airline_theme='monochrome'
let g:airline_powerline_fonts = 1
" show buffers (if only one tab)
"let g:airline#extensions#tabline#enabled = 1
