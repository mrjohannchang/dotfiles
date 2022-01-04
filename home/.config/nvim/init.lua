-- Built-in {
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.hlsearch = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "░" }

vim.opt.number = true

vim.opt.spell = true

vim.opt.splitbelow = true

vim.opt.wrap = false
-- }


-- Plugins {
require "paq" {
  "nvim-lualine/lualine.nvim";
  "kyazdani42/nvim-web-devicons";  -- requried by "nvim-lualine/lualine.nvim"
}
-- }


-- Reselect visual block after indent/outdent {
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
-- }


-- Enable moving up and down with j and k in wrapped lines {
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
-- }


-- Clear the search highlight with <LEADER> + / {
vim.api.nvim_set_keymap("n", "<LEADER>/", ":nohlsearch<CR>", { noremap = true, silent = true })
-- }


-- Saving files as root with w!! {
vim.api.nvim_set_keymap("c", "w!!", "%!sudo tee > /dev/null %", { noremap = true })
-- }


-- Better command-line editing {
-- <CTRL> + j and <CTRL> + k move to lines that have identical prefixes
vim.api.nvim_set_keymap("c", "<C-j>", "<UP>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-k>", "<DOWN>", { noremap = true })

-- <CTRL> + a and <CTRL> + e move to the beginning and the end of the line
vim.api.nvim_set_keymap("c", "<C-a>", "<HOME>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-e>", "<END>", { noremap = true })
-- }


-- Toggle paste mode with <F2> {
-- https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
vim.api.nvim_set_keymap("n", "<F2>", ":set invpaste paste?<CR>", { noremap = true })
vim.opt.pastetoggle="<F2>"

-- Leave paste mode on leaving insert mode
vim.api.nvim_command("autocmd InsertLeave * set nopaste")
-- }


-- Load config for light background if needed {
pcall(require, "init-light")
-- }
