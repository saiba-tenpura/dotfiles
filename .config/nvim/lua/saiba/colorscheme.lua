local hl = vim.api.nvim_set_hl

-- CMP
hl(0, 'PMenu', {ctermbg=234, ctermfg=7})
hl(0, 'CmpItemAbbrDeprecated', {ctermbg='NONE', strikethrough=true, ctermfg=8})
hl(0, 'CmpItemAbbrMatch', {ctermbg='NONE', ctermfg=3})
hl(0, 'CmpItemAbbrMatchFuzzy', {link='CmpIntemAbbrMatch'})
hl(0, 'CmpItemKindVariable', {ctermbg='NONE', ctermfg=11})
hl(0, 'CmpItemKindInterface', {link='CmpItemKindVariable'})
hl(0, 'CmpItemKindText', {link='CmpItemKindVariable'})
hl(0, 'CmpItemKindFunction', {ctermbg='NONE', ctermfg=2})
hl(0, 'CmpItemKindMethod', {link='CmpItemKindFunction'})
hl(0, 'CmpItemKindKeyword', {ctermbg='NONE', ctermfg=6})
hl(0, 'CmpItemKindProperty', {link='CmpItemKindKeyword'})
hl(0, 'CmpItemKindUnit', {link='CmpItemKindKeyword'})

-- LSP
hl(0, 'SignColumn', {link='Normal'})
hl(0, 'DiagnosticVirtualTextError', {ctermfg=124})
hl(0, 'DiagnosticVirtualTextInfo', {ctermfg=1})
hl(0, 'DiagnosticVirtualTextWarn', {ctermfg=166})
hl(0, 'DiagnosticVirtualTextHint', {ctermfg=234})
