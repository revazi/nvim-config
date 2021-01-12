# nvim-config


## Installation
Clone repo under `~/.vim` folder.
Start vim and run `PlugInstall`

#### Fonts
Install fonts under `fonts`

#### Configure NeoVIM with VIM
Add `init.vim` under `~/.config/vim` with this inside
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc
```
