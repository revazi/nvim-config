" Plug (vim-plug) - plugin manager
" https://github.com/junegunn/vim-plug 
" 
" https://neovim.io/
" http://nerditya.com/code/guide-to-neovim/
"

Plug 'GutenYe/json5.vim'

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
Plug 'morhetz/gruvbox'
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
Plug 'artanikin/vim-synthwave84'
Plug 'wojciechkepka/vim-github-dark'


Plug 'editorconfig/editorconfig-vim'

" NERD Tree - tree explorer
" https://github.com/scrooloose/nerdtree
" http://usevim.com/2012/07/18/nerdtree/
" (loaded on first invocation of the command)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'APZelos/blamer.nvim'
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_prefix = ' 📍 '
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_template = '<committer> · <summary> · <committer-time>'


if executable('ag')
  Plug 'rking/ag.vim'
endif

"" CocInstall coc-json coc-html coc-css coc-python coc-tsserver coc-rls coc-vetur
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-rls',
  \ 'coc-vetur', 
  \ 'coc-prettier',
  \ 'coc-pairs'
  \ ]

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

autocmd FileType python let b:coc_root_patterns =
        \ ['.git', '.env', 'pyproject.toml', 'Pipfile']
autocmd FileType javascript,typescript,typescript.tsx let b:coc_root_patterns =
        \ ['.git', 'package-lock.json', 'yarn.lock']

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call OnLoadCoc()

" For coc-settings.json json
autocmd FileType json syntax match Comment +\/\/.\+$+

" from neoclide coc-css, keyword hint for completions
autocmd FileType scss setl iskeyword+=@-@

Plug 'vim-python/python-syntax'

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
" Plug 'ryanoasis/vim-devicons'

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
    \ 'for': ['javascript', 'typescript', 'typescriptreact', 'vue', 'markdown', 'markdown.mdx'] }

  autocmd BufWritePre *.md,*.mdx,*.ts,*.tsx,*.js,*.jsx execute ':Prettier'
endif

if executable('black')
  autocmd BufWritePost *.py silent !black % --quiet
endif

if executable('isort')
  autocmd BufWritePost *.py silent !isort % --quiet
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



