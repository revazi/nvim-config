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
" autocmd CursorHoldI * :call <SID>show_hover_doc()
" autocmd CursorHold * :call <SID>show_hover_doc()


" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" auto switch current working directory to current buffer (not recommended)
"autocmd BufEnter * :cd %:p:h


" tagbar autopen
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)


" http://vim.wikia.com/wiki/Highlight_current_line
" http://stackoverflow.com/questions/8750792/vim-highlight-the-whole-current-line
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-events
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

augroup netrw_window_fix
  autocmd!
  autocmd filetype netrw call Set_netrw_maps()
augroup END

autocmd VimEnter * wincmd p

" switch cwd
" autocmd BufEnter * silent! lcd %:p:h

" autocmd CursorHold * silent call CocActionAsync('highlight')
