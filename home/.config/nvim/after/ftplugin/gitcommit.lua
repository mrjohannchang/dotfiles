vim.wo.spell = true

-- NOTE: Ensures that :q and :x work with neovim-remote
-- https://github.com/mhinz/neovim-remote#typical-use-cases
vim.bo.bufhidden = 'delete'
