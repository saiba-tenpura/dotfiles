-- Check :help options for more informations

local options = {
  -- Clipboard access
  clipboard = "unnamedplus",
  -- Indentation
  expandtab = true,
  shiftwidth = 2,
  softtabstop = 2,
  tabstop = 2,
  -- No backups
  backup = false,
  swapfile = false,
  -- Search
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  showmatch = true,           -- Highlight matching {[()]},
  smartcase = true,
  wildmenu = true,            -- Display matches in tab list
  -- UI
  number = true,
  showmode = false,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  wrap = false,
  -- Miscellaneous
  fileencoding = "utf-8",
  laststatus = 3,
  undodir = vim.fn.stdpath("data") .. "/undodir",
  undofile = true,
}

-- Set Vim options
for name, value in pairs(options) do
  vim.opt[name] = value
end

-- Add search path to current directory recursively
vim.opt.path:append({ '**' })

-- Ignore certain files and directories when searching
vim.opt.wildignore:append({ ".git", ".hg", ".svn" })
vim.opt.wildignore:append({ "*.kgb", "*.rar", "*.zip", "*.tar.bz2", "*.tar.gz", "*.tar.xz" })

-- Hide EOB
vim.opt.fillchars:append('eob: ')
