"===============================================================================
" Autocommands
"===============================================================================
call lib#SourceIfExists("~/.vim/settings/autocmd.vim")
"===============================================================================

"===============================================================================
" Sensible
"===============================================================================
call lib#SourceIfExists("~/.vim/settings/sensible.vim")
"===============================================================================

"===============================================================================
" Keymappings 
"===============================================================================
call lib#SourceIfExists("~/.vim/settings/keymappings.vim")
"===============================================================================
"
"===============================================================================
" Settings
"===============================================================================
call lib#SourceIfExists("~/.vim/settings/settings.vim")
"===============================================================================

"===============================================================================
" Plugins
"===============================================================================
call lib#SourceIfExists("~/.vim/settings/plugin_loader.vim")
call plugin_loader#PlugInit()
"===============================================================================


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
  colorscheme gruvbox
  set list
endfunction

function! Dark()
  echom "set bg=dark"
  set background=dark
  colorscheme gruvbox
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
      \ 'down':    '40%'
      \ })

command! -nargs=* FZFAg call fzf#run({
      \ 'source':  printf('ag --nogroup --column --color "%s"',
      \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
      \ 'sink*':    function('<sid>ag_handler'),
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
      \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '40%'
      \ })

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" =====================================
" Init
" =====================================
silent call Dark()
