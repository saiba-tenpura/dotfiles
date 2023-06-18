local overrides = {
  -- CMP
  PMenu = {ctermbg=234, ctermfg=7},
  CmpItemAbbrDeprecated = {ctermbg='NONE', strikethrough=true, ctermfg=8},
  CmpItemAbbrMatch = {ctermbg='NONE', ctermfg=3},
  CmpItemAbbrMatchFuzzy = {link='CmpIntemAbbrMatch'},
  CmpItemKindVariable = {ctermbg='NONE', ctermfg=11},
  CmpItemKindInterface = {link='CmpItemKindVariable'},
  CmpItemKindText = {link='CmpItemKindVariable'},
  CmpItemKindFunction = {ctermbg='NONE', ctermfg=2},
  CmpItemKindMethod = {link='CmpItemKindFunction'},
  CmpItemKindKeyword = {ctermbg='NONE', ctermfg=6},
  CmpItemKindProperty = {link='CmpItemKindKeyword'},
  CmpItemKindUnit = {link='CmpItemKindKeyword'},

  -- LSP
  SignColumn = {link='Normal'},
  DiagnosticVirtualTextError = {ctermfg=9},
  DiagnosticVirtualTextInfo = {ctermfg=1},
  DiagnosticVirtualTextWarn = {ctermfg=166},
  DiagnosticVirtualTextHint = {ctermfg=234},
}

for k,v in pairs(overrides) do
  vim.api.nvim_set_hl(0, k, v)
end
