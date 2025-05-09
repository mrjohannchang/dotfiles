-- Built-in {
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.fileformats = "unix,dos"

vim.opt.hlsearch = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "░" }

vim.opt.number = true

vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.wrap = true

vim.opt.mouse = ""
vim.opt.background = "dark"

vim.opt.ignorecase = true

if package.config:sub(1,1) == '\\' then
  vim.opt.shellslash = true
end

vim.opt.splitright = true  -- temporary for CopilotChat.nvim
-- } Built-in


-- Reselect visual block after indent/outdent {
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
-- } Reselect visual block after indent/outdent


-- Enable moving up and down with j and k in wrapped lines {
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
-- } Enable moving up and down with j and k in wrapped lines


-- Clear the search highlight with <LEADER>/ {
vim.keymap.set("n", "<LEADER>/", "<CMD>nohlsearch<CR>", { noremap = true, silent = true })
-- } Clear the search highlight with <LEADER>/


-- Saving files as root with w!! {
vim.keymap.set("c", "w!!", "%!sudo tee > /dev/null %", { noremap = true })
-- } Saving files as root with w!!


-- Better buffer navigation {
-- Move to the previous buffer
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { noremap = true })
-- Move to the next buffer
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { noremap = true })
-- } Better buffer navigation


-- Better command-line editing {
-- <CTRL> + j and <CTRL> + k move to lines that have identical prefixes
vim.keymap.set("c", "<C-k>", "<UP>", { noremap = true })
vim.keymap.set("c", "<C-j>", "<DOWN>", { noremap = true })

-- <CTRL> + a and <CTRL> + e move to the beginning and the end of the line
vim.keymap.set("c", "<C-a>", "<HOME>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<END>", { noremap = true })

-- <CTRL> + b and <CTRL> + f move left and right
vim.keymap.set("c", "<C-b>", "<LEFT>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<RIGHT>", { noremap = true })
-- } Better command-line editing


-- custom pre-init settings {
pcall(require, "pre-init")
-- } custom pre-init settings


-- init lazy.nvim plugin management {
require("init-lazy")
-- }


-- Load config for light background if available {
pcall(require, "init-light")
-- } Load config for light background if available


-- custom post-init settings {
pcall(require, "post-init")
-- } custom post-init settings


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- } Reference
