" Based on: https://stackoverflow.com/questions/26962999/wrong-indentation-when-editing-yaml-in-vim
autocmd FileType yaml,yml setlocal
	\tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	\indentkeys-=0# indentkeys-=<:>
