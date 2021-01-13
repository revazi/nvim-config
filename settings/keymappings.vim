" =====================================
" Understand mapping modes:
" http://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping#answer-3776182
" http://stackoverflow.com/questions/22849386/difference-between-nnoremap-and-inoremap#answer-22849425
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
xmap \ gc

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


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>


" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x><C-x> <C-\><C-n><C-w>q
tnoremap <C-x> <C-\><C-n>

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''

" toggle colors to optimize based on light or dark background
nnoremap <leader>c :call ToggleLightDark()<CR>

nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>

nmap <space> :<C-u>FZFR<CR>

nnoremap <silent> <C-F> :<C-u>FZFAg<cr>
nnoremap <silent> <C-f> :<C-u>FZFAgRoot<cr>


" Traversal
" tnoremap <C-h> <C-\><C-n><C-w>h
" tnoremap <C-j> <C-\><C-n><C-w>j
" tnoremap <C-k> <C-\><C-n><C-w>k
" tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
