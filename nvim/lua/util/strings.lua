---@class UtilStrings
local M = {}

--- Performs plain substring replacement, treating `pattern` and `replacement` as literal strings.
--- Special characters in the pattern are escaped automatically.
--- @param s string The input string to perform replacements on.
--- @param toReplace string The substring to be replaced (treated literally).
--- @param replacement string The replacement string (treated literally).
--- @param n? integer Maximum number of replacements to perform (optional).
--- @return string str The modified string after replacements.
--- @return number replacement The number of replacements made.
M.replace = function(s, toReplace, replacement, n)
  return string.gsub(s, string.gsub(toReplace, "%p", "%%%0"), string.gsub(replacement, "%%", "%%%%"), n)
end

return M
