--- Performs plain substring replacement, with no characters in `pattern` or `replacement` being considered magic.
-- @tparam string str
-- @tparam string pattern
-- @tparam string replacement
-- @param[opt] n
-- @treturn string
-- @treturn number
function string.replace(s, patt, repl, n)
  return string.gsub(s, string.gsub(patt, "%p", "%%%0"), string.gsub(repl, "%%", "%%%%"), n)
end
