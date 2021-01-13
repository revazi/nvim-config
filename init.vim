"===============================================================================
" Autocommands
"===============================================================================
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

" Redraw since vim gets corrupt for no reason
au FocusGained * redraw! " redraw screen on focus

autocmd FileType * noremap <silent><leader>f :call Preserve("normal gg=G")<CR>
autocmd FileType javascript noremap <silent><leader>f :call Preserve("normal gg=G")<CR>
autocmd FileType html,mustache,jinja,hbs,handlebars,html.handlebars noremap <silent><leader>f :call Preserve("normal gg=G")<CR>

autocmd FileType ejs,jst noremap <silent><leader>f :call Preserve("normal gg=G")<CR>
autocmd FileType less, scss, sass noremap <silent><leader>f :call Preserve("normal gg=G")<CR>

autocmd BufNewFile,BufRead *.ejs,*.jst setlocal filetype=html.jst  " https://github.com/briancollins/vim-jst/blob/master/ftdetect/jst.vim
autocmd BufNewFile,BufRead *.handlebars setlocal filetype=html.mustache
autocmd! BufNewFile,BufRead *.js.php set filetype=javascript
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType vim setlocal autoindent expandtab smarttab shiftwidth=2 softtabstop=2 keywordprg=:help
autocmd FileType html,mustache,jst,ejs,erb,handlebars,html.handlebars setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

autocmd FileType sh,csh,tcsh,zsh setlocal autoindent expandtab smarttab shiftwidth=4 softtabstop=4
autocmd BufWritePost,FileWritePost ~/.Xdefaults,~/.Xresources silent! !xrdb -load % >/dev/null 2>&1

autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
autocmd FileType gitcommit setlocal spell
autocmd FileType gitrebase nnoremap <buffer> S :Cycle<CR>

" map :BufClose to :bq and configure it to open a file browser on close
let g:BufClose_AltBuffer = '.'
cnoreabbr <expr> bq 'BufClose'

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.go setlocal ft=go
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType html,xhtml,xml,htmldjango,jinja.html,jinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.tmpl,*.jinja,*.jinja2 setlocal ft=jinja.html
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

autocmd FileType css,scss,less setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 formatoptions+=nqt textwidth=74
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
autocmd FileType javascript,typescript,typescript.tsx setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let javascript_enable_domhtmlcss=1
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown setlocal textwidth=80
autocmd FileType rust setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Show documentation for the word under the cursor
"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

syntax enable
set backspace=indent,eol,start
set foldenable                  " Auto fold code
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

" Plug (vim-plug) - plugin manager
" https://github.com/junegunn/vim-plug 
" 
" https://neovim.io/
" http://nerditya.com/code/guide-to-neovim/
"
" Setting file was sourced from:
" https://gist.github.com/subfuzion/7d00a6c919eeffaf6d3dbf9a4eb11d64
"
"
" =====================================
call plug#begin('~/.vim/plugged')
" -------------------------------------


" various color schemes (neovim default is 'dark')
" http://vimcolors.com/
Plug 'freeo/vim-kalisi'
Plug 'w0ng/vim-hybrid'
Plug 'bitterjug/vim-colors-bitterjug'
Plug 'jonathanfilip/vim-lucius'
Plug 'crusoexia/vim-monokai'
Plug 'jacoborus/tender.vim'
Plug 'pbrisbin/vim-colors-off'
Plug 'muellan/am-colors'
Plug 'blueshirts/darcula'
Plug 'NLKNguyen/papercolor-theme'


Plug 'editorconfig/editorconfig-vim'

" NERD Tree - tree explorer
" https://github.com/scrooloose/nerdtree
" http://usevim.com/2012/07/18/nerdtree/
" (loaded on first invocation of the command)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'


if executable('ag')
  Plug 'rking/ag.vim'
endif

function! OnLoadCoc()
  " use <tab> for trigger completion and navigate next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()

  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Remap keys for gotos
  nmap <F12> <Plug>(coc-definition)
  nmap <C-F12> <Plug>(coc-type-definition)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> <leader>g <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> <leader>G <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
  nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
  nmap <leader>do <Plug>(coc-codeaction)
  nmap <leader>rn <Plug>(coc-rename)
endfunction

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call OnLoadCoc()

" For coc-settings.json json
autocmd FileType json syntax match Comment +\/\/.\+$+

" TagBar
Plug 'majutsushi/tagbar'

" vim-airline
" Enhanced statusline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" Adds icons to your plugins
" Install fonts before running PlugInstall
" OSX: brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
" OR see full instructions here for other platforms: https://github.com/ryanoasis/nerd-fonts#font-installation
Plug 'ryanoasis/vim-devicons'

" Save/restore session support
" https://github.com/tpope/vim-obsession
" tmux users also see: https://github.com/tmux-plugins/tmux-resurrect/blob/master/docs/restoring_vim_and_neovim_sessions.md
Plug 'tpope/vim-obsession'

Plug 'tomtom/tcomment_vim'

" Markdown support
" https://github.com/plasticboy/vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'airblade/vim-rooter'

" OMG - insanely awesome fuzzy search and blazing fast grep
" https://github.com/junegunn/fzf (parent project)
" https://github.com/junegunn/fzf.vim (more extensive wrapper)
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.rkhrm332m
" To update: :PlugUpdate fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


" indentline
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

if executable('node')
  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['javascript', 'typescript', 'vue', 'markdown', 'markdown.mdx'] }

  autocmd BufWritePre *.md,*.mdx,*.ts,*.tsx,*.js,*.jsx execute ':Prettier'
endif

Plug 'jparise/vim-graphql'
Plug 'cakebaker/scss-syntax.vim'

if executable('node')
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'posva/vim-vue'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'pangloss/vim-javascript'
endif


" -------------------------------------
" Add plugins
call plug#end()
" =====================================
"
"
" These are the basic settings to get the font to work (required):
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\:h12
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1
"
" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =====================================
" Initial settings
" =====================================

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

" highlight matches when searching
" Use C-l to clear (see key map section)
set hlsearch

" Line numbering
" Toggle set to ',n' in key map section
"set nonumber

" Disable line wrapping
" Toggle set to ',w' in key map section
set nowrap

" Fix E353: Nothing in register "
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" enable line and column display
set ruler

"disable showmode since using vim-airline; otherwise use 'set showmode'
set noshowmode

" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on

" scroll a bit horizontally when at the end of the line
set sidescroll=6

" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full

" markdown
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1

" auto switch current working directory to current buffer (not recommended)
"autocmd BufEnter * :cd %:p:h

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" Use Ag (the silver searcher) instack of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" =====================================
" Theme color scheme settings
" =====================================
" blue
" darkblue
" default
" delek
" desert
" elflord
" evening
" koehler
" morning
" murphy
" pablo
" peachpuff
" ron
" shine
" slate
" torte
" zellner
" -------------------------------------

function! Light()
  echom "set bg=light"
  set background=light
  colorscheme PaperColor
  set list
endfunction

function! Dark()
  echom "set bg=dark"
  set background=dark
  colorscheme PaperColor
  "darcula fix to hide the indents:
  set nolist
endfunction

function! ToggleLightDark()
  if &bg ==# "light"
    call Dark()
  else
    call Light()
  endif
endfunction

" adjustments
"hi Statement ctermfg=1 guifg=#60BB60
"hi Constant ctermfg=4

" for macvim
"
" Disable scrollbar in gui
" set scrolloff=9999
" hide right scrollbar
set guioptions-=r

" =====================================
" key map
" Understand mapping modes:
" http://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping#answer-3776182
" http://stackoverflow.com/questions/22849386/difference-between-nnoremap-and-inoremap#answer-22849425
" =====================================


" =====================================
" From vim setup
" =====================================
" change the leader key from "\" to ";" ("," is also popular)
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","



" thanks terryma: https://github.com/terryma/dotfiles/blob/master/.vimrc
" d: Delete into the blackhole register to not clobber the last yank
nnoremap d "_d
" dd: I use this often to yank a single line, retain its original behavior
nnoremap dd dd


" Up Down Left Right resize splits
nnoremap <up> <c-w>5+
nnoremap <down> <c-w>5-
nnoremap <left> <c-w>5<
nnoremap <right> <c-w>5>


" Visual Mode Ctrl Key Mappings

" Ctrl-c: Copy (works with system clipboard due to clipboard setting)
" vnoremap <c-c> y`]

" Ctrl-r: Easier search and replace
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" Ctrl-s: Easier substitue
vnoremap <c-s> :s/\%V//g<left><left><left>

" Visual Mode Key Mappings

" y: Yank and go to end of selection
xnoremap y y`]

" p: Paste in visual mode should not replace the default register with the
" deleted text
xnoremap p "_dP

" d: Delete into the blackhole register to not clobber the last yank. To 'cut',
" use 'x' instead
xnoremap d "_d

" \: Toggle comment
" nerdcommenter:
" xmap \ <Leader>c<space>
" tcomment:
xmap \ gc<space>

" Enter: Highlight visual selections
xnoremap <silent> <CR> y:let @/ = @"<cr>:set hlsearch<cr>

" Backspace: Delete selected and go into insert mode
xnoremap <bs> c

" <|>: Reselect visual block after indent
xnoremap < <gv
xnoremap > >gv

" .: repeats the last command on every line
xnoremap . :normal.<cr>

" @: repeats macro on every line
xnoremap @ :normal@

" Tab: Indent
xmap <Tab> >

" shift-tab: unindent
xmap <s-tab> <

noremap <leader>x :Ex<CR>
noremap <leader>r : RangerWorkingDirectory<CR>

" Buffer Traversal {{{
nnoremap <silent> <Leader>d :BD<cr>

" derived from shell commands (Ctrl-b is back a char in command line)
" nnoremap <silent> <Leader>p :call PrevBufferOrQuickfix()<CR>
" nnoremap <silent> <Leader>n :call NextBufferOrQuickfix()<CR>
"
" nnoremap <silent> <Leader>c :BB<CR>
" nnoremap <silent> <Leader><BS> :BB<CR>
" nnoremap <silent> <Leader><Del> :BB<CR>


" Netrw traversal
" https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f#file-netrw-txt-L4
augroup netrw_window_fix
  autocmd!
  autocmd filetype netrw call Set_netrw_maps()
augroup END
function! Set_netrw_maps()
  noremap <buffer> <C-l> <C-w>l
endfunction

nnoremap <silent> K :call CocAction('doHover')<CR>

nnoremap <C-=> <C-w>=

map ;] :bnext<CR>
map <Leader>] :bnext<CR>
map ;[ :bprev<CR>
map <Leader>[ :bprev<CR>


" =====================================
" end from vim setup
" =====================================

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ,, <Esc>



" Toggle NERDTree
" Can't get <C-Space> by itself to work, so this works as Ctrl - space - space
" https://github.com/neovim/neovim/issues/3101
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim#answer-24550772
"nnoremap <C-Space> :NERDTreeToggle<CR>
"nmap <C-@> <C-Space>
nnoremap <silent> <C-space> :NERDTreeToggle<CR>
nnoremap <silent> <C-n><C-f> :NERDTreeToggle<CR>

nnoremap <silent> <leader>f :NERDTreeToggle<CR>

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>

" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
" https://github.com/neovim/neovim/issues/2048
nnoremap <C-h> :bp<CR>

" close buffer
nnoremap <silent> <leader>bd :bd<CR>

" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>

" list buffers
nnoremap <silent> <leader>bl :ls<CR>
" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>

" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" vimux
" https://raw.githubusercontent.com/benmills/vimux/master/doc/vimux.txt
nnoremap <leader>vc :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <leader>vq :VimuxCloseRunner<CR>
nnoremap <leader>vx: VimuxInterruptRunner<CR>


" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" tnoremap <Esc> <C-\><C-n>
" tnoremap <C-h> <C-\><C-n><C-w>h
" tnoremap <C-j> <C-\><C-n><C-w>j
" tnoremap <C-k> <C-\><C-n><C-w>k
" tnoremap <C-l> <C-\><C-n><C-w>l

" Traversal
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x> <C-\><C-n><C-w>q

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''

" toggle colors to optimize based on light or dark background
nnoremap <leader>c :call ToggleLightDark()<CR>

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

let s:hidden_all = 0
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    TagbarClose
    NERDTreeClose
    set foldcolumn=10

  else
    set foldcolumn=0
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2 
    set showcmd
    NERDTree
    " NERDTree takes focus, so move focus back to the right
    " (note: "l" is lowercase L (mapped to moving right)
    wincmd l
    TagbarOpen

  endif
endfunction

nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>

" =====================================
" Custom find
" =====================================
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"
" vim-rooter
"
"
" This is checked for before initialization.
" https://github.com/airblade/vim-rooter/blob/3509dfb/plugin/rooter.vim#L173
let g:rooter_manual_only = 1
let g:rooter_silent_chdir = 1
let g:rooter_patterns = [
      \ 'manage.py', 
      \ '.venv/', 
      \ '.env/',
      \ '.env3/',
      \ '.venv3/',
      \ 'Rakefile',
      \ '.git/',
      \ 'gulpfile.js',
      \ 'bower.json',
      \ 'Gruntfile.js',
      \ 'Gemfile',
      \ 'Procfile',
      \ '.svn',
      \ '.hg',
      \ 'Pipfile',
      \ ]

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

if v:version >= 801  " Floating window on 8.1+ https://github.com/junegunn/fzf/blob/master/README-VIM.md
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


function! s:find_root()
  for vcs in ['.venv', 'Pipfile', 'Procfile', 'Gemfile', '.git', '.svn', '.hg']
    let dir = finddir(vcs.'/..', ';')
    if !empty(dir)
      execute 'FZF' dir
      return
    endif
  endfor
  FZF
endfunction

" command! FZFR call s:find_root()

command! -bang FZFR
      \ call fzf#run(fzf#wrap('my-stuff', {'dir': FindRootDirectory()}, <bang>0))


nmap <space> :<C-u>FZFR<CR>


" =====================================
" Custom styling
" =====================================

" http://stackoverflow.com/questions/9001337/vim-split-bar-styling
set fillchars+=vert:\ 

" http://vim.wikia.com/wiki/Highlight_current_line
" http://stackoverflow.com/questions/8750792/vim-highlight-the-whole-current-line
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-events
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline

" tagbar autopen
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" =====================================
" auto completion
" =====================================
set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

"set completeopt+=noinsert
"set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1


"""
" AG Search
"
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim
"
" Accessed March 14, 2018
"""
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
        \ 'ctrl-v': 'vertical split',
        \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* FZFAgRoot call fzf#run({
      \ 'source':  printf('ag --nogroup --column --color "%s" %s',
      \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\'), FindRootDirectory()),
      \ 'sink*':    function('<sid>ag_handler'),
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
      \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '50%'
      \ })

command! -nargs=* FZFAg call fzf#run({
      \ 'source':  printf('ag --nogroup --column --color "%s"',
      \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
      \ 'sink*':    function('<sid>ag_handler'),
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
      \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '50%'
      \ })

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

nnoremap <silent> <C-F> :<C-u>FZFAg<cr>
nnoremap <silent> <C-f> :<C-u>FZFAgRoot<cr>

" =====================================
" Init
" =====================================
silent call Dark()
autocmd VimEnter * wincmd p
