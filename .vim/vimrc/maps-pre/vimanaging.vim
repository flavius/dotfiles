function! ShowScripts()
    redir @c | scriptnames | redir END | vnew | put c
endfunction
