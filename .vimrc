" Activate syntax highlight
syntax on

" Map Tab to Esc
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>"^
inoremap <Leader><Tab> <Tab>

call plug#begin('~/.vim/plugged')

Plug 'Zenburn'

call plug#end()

colors zenburn
