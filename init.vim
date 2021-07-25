lua << EOF
require("packer").startup(function()
  use "wbthomason/packer.nvim"
end)
EOF


nnoremap <SPACE> <Nop>
let mapleader = " "


augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END


" hybrid line numbers on
set number relativenumber
set nu rnu
" spaces, not tabs
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap


nnoremap <leader>bk <cmd>q<cr>
noremap <C-k> <cmd>m -2<cr>
noremap <C-j> <cmd>m +1<cr>


nnoremap <leader>ps <cmd>PackerSync<cr>
nnoremap <leader>pc <cmd>PackerCompile<cr>
