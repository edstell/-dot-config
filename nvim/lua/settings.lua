-- Set leader to ','.
vim.g.mapleader = ","

-- Options.
vim.opt.ttyfast = true
vim.opt.mouse = "a"
vim.opt.colorcolumn = "80"
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.updatetime = 300

-- Clipboard
if vim.fn.has("unnamedplus") == 1 then
    vim.opt.clipboard:append("unnamed")
    vim.opt.clipboard:append("unnamedplus")
end

-- Undo settings
if vim.fn.has("persistent_undo") == 1 then
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath("config") .. "/tmp/undo"
end
