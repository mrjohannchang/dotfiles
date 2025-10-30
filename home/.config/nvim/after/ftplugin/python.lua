vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

if vim.fn.executable("ruff") == 1 then
  if vim.fn.findfile("ruff.toml", ".;") ~= "" then
    local python_auto_format_group = vim.api.nvim_create_augroup("PythonAutoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.py",
      callback = function()
        local p = vim.fn.getpos(".")
        vim.cmd(":silent exec '!ruff format %'")
        vim.fn.setpos(".", p)
      end,
      group = python_auto_format_group,
    })
  end
end
