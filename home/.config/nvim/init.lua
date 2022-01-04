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


-- Workarounds {
-- https://github.com/neovim/neovim/issues/6660
if vim.fn.has("win32") then
  vim.api.nvim_set_keymap("", "<C-z>", "", { noremap = true })
end
-- }


-- Plugins {
require('packer').startup(function(use)
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  use {
    "nvim-lualine/lualine.nvim",
    requires = { { "kyazdani42/nvim-web-devicons" } },
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
-- }


-- Reselect visual block after indent/outdent {
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
-- }


-- Enable moving up and down with j and k in wrapped lines {
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
-- }


-- Clear the search highlight with <LEADER>/ {
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


-- telescope.nvim {
vim.api.nvim_set_keymap("n", "<LEADER>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
-- }


-- Load config for light background if available {
pcall(require, "init-light")
-- }


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- }
