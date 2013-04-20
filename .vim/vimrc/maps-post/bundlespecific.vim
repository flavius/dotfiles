" Panels and windows {{{
    " ListToggle {
        let g:lt_location_list_toggle_map = '<Leader>l'
        let g:lt_quickfix_list_toggle_map = '<Leader>q'
    " }
    " ZoomWin {
        " <C-w>o to toggle
    " }
    " Gundo {
        nnoremap <Leader>g :GundoToggle<CR>
    " }
" }}}
" Visuals {{{
    "  vim-showmarks {
        nnoremap <Leader>ms :DoShowMarks<CR>
        nnoremap <Leader>mh :NoShowMarks<CR>
        "  Left unused:
        "  DoShowMarks!
        "  NoShowMarks!
        "  [count]ShowMarksOnce for [count] CursorHold events
        "  [count]PreviewMarks
    "  }
" }}}
" vim:set foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
