set background=dark
if exists('g:colors_name')
hi clear
if exists('syntax_on')
syntax reset
endif
endif
let g:colors_name = 'lushwal'
highlight Normal guifg=#C3C4C6 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight! link User Normal
highlight Bold guifg=#C3C4C6 guibg=#101923 guisp=NONE blend=NONE gui=bold
highlight Boolean guifg=#7D2632 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Character guifg=#6D2631 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=#7B838E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Comment guifg=#C3C4C6 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Conceal guifg=#5E6773 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight! link Whitespace Conceal
highlight Conditional guifg=#E4DF77 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Constant guifg=#7D2632 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Cursor guifg=#101923 guibg=#C3C4C6 guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=#7B838E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=NONE guibg=#5E6773 guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=#C3C4C6 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight Debug guifg=#6D2631 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=#E4DF77 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Delimiter guifg=#7D2633 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticError guifg=#6D2631 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticHint guifg=#F60934 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticInfo guifg=#AF2335 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticUnderlineError guifg=#6D2631 guibg=NONE guisp=#6D2631 blend=NONE gui=underline
highlight DiagnosticUnderlineHint guifg=#F60934 guibg=NONE guisp=#F60934 blend=NONE gui=underline
highlight DiagnosticUnderlineInfo guifg=#AF2335 guibg=NONE guisp=#AF2335 blend=NONE gui=underline
highlight DiagnosticUnderlineWarn guifg=#8D2533 guibg=NONE guisp=#8D2533 blend=NONE gui=underline
highlight DiagnosticWarn guifg=#8D2533 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffAdd guifg=#BD1F36 guibg=#5E6773 guisp=NONE blend=NONE gui=bold
highlight! link DiffAdded DiffAdd
highlight DiffChange guifg=#9FA3A8 guibg=#5E6773 guisp=NONE blend=NONE gui=NONE
highlight DiffDelete guifg=#6D2631 guibg=#5E6773 guisp=NONE blend=NONE gui=bold
highlight! link DiffRemoved DiffDelete
highlight! link diffRemoved DiffDelete
highlight DiffFile guifg=#6D2631 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight DiffLine guifg=#AF2335 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight DiffNewFile guifg=#BD1F36 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight DiffText guifg=#AF2335 guibg=#5E6773 guisp=NONE blend=NONE gui=NONE
highlight Directory guifg=#AF2335 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight EndOfBuffer guifg=#C3C4C6 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight Error guifg=#6D2631 guibg=#C3C4C6 guisp=NONE blend=NONE gui=NONE
highlight ErrorMsg guifg=#6D2631 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight Exception guifg=#6D2631 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Float guifg=#7D2632 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FoldColumn guifg=#AF2335 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight Folded guifg=#C3C4C6 guibg=#5E6773 guisp=NONE blend=NONE gui=italic
highlight Function guifg=#AF2335 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Identifier guifg=#F60934 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight IncSearch guifg=#5E6773 guibg=#7D2632 guisp=NONE blend=NONE gui=NONE
highlight Include guifg=#AF2335 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Italic guifg=#C3C4C6 guibg=#101923 guisp=NONE blend=NONE gui=italic
highlight Keyword guifg=#E4DF77 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Label guifg=#8D2533 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LineNr guifg=#9FA3A8 guibg=#101923 guisp=NONE blend=NONE gui=NONE
highlight Macro guifg=#6D2631 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MatchParen guifg=#C3C4C6 guibg=#9FA3A8 guisp=NONE blend=NONE gui=NONE
