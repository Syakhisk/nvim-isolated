---@class LibHelpers
local M = {}

--- Get the Neovim configuration path
--- @return string config_path The path to the Neovim configuration directory
M.config_path = function()
  return vim.fn.stdpath("config")
end

--- Get the Neovim data path
--- @return string data_path The path to the Neovim data directory
M.data_path = function()
  return vim.fn.stdpath("data")
end

--- Get the Neovim cache path
--- @return string cache_path The path to the Neovim cache directory
M.cache_path = function()
  return vim.fn.stdpath("cache")
end

--- Get the Neovim state path
--- @return string state_path The path to the Neovim state directory
M.state_path = function()
  return vim.fn.stdpath("state")
end

--- Get the current working directory
--- @return string cwd The current working directory
M.cwd = function()
  return vim.fn.getcwd()
end

--- Get the path to the current file
--- @return string current_file_path The path to the currently open file
M.current_file_path = function()
  return vim.fn.expand("%:p")
end

--- Get the directory of the current file
--- @return string current_file_dir The directory containing the currently open file
M.current_file_dir = function()
  return vim.fn.expand("%:p:h")
end

--- Check if we're running in a Git repository
--- @return boolean is_git_repo True if current directory is in a git repository
M.is_git_repo = function()
  local git_dir = vim.fn.finddir(".git", ".;")
  return git_dir ~= ""
end

--- Get the Git root directory
--- @return string|nil git_root The root directory of the git repository, or nil if not in a git repo
M.git_root = function()
  if not M.is_git_repo() then
    return nil
  end

  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 then
    return git_root
  end
  return nil
end

--- Get the home directory
--- @return string home_path The user's home directory
M.home = function()
  return vim.fn.expand("~")
end

--- Check if running on Windows
--- @return boolean is_windows True if running on Windows
M.is_windows = function()
  return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
end

--- Check if running on macOS
--- @return boolean is_macos True if running on macOS
M.is_macos = function()
  return vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1
end

--- Check if running on Linux
--- @return boolean is_linux True if running on Linux
M.is_linux = function()
  return vim.fn.has("unix") == 1 and not M.is_macos()
end

--- Get the OS name
--- @return "windows"|"macos"|"linux"|"unknown" os_name The operating system name
M.os_name = function()
  if M.is_windows() then
    return "windows"
  elseif M.is_macos() then
    return "macos"
  elseif M.is_linux() then
    return "linux"
  else
    return "unknown"
  end
end

--- Check if a command exists in PATH
--- @param cmd string The command to check
--- @return boolean exists True if the command exists
M.has_command = function(cmd)
  return vim.fn.executable(cmd) == 1
end

--- Get Neovim version information
--- @return table version_info Version information table
M.nvim_version = function()
  return vim.version()
end

--- Check if current Neovim version meets minimum requirement
--- @param min_version string Minimum version in format "0.9.0"
--- @return boolean meets_requirement True if current version meets requirement
M.nvim_version_check = function(min_version)
  return vim.fn.has("nvim-" .. min_version) == 1
end

return M
