vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

if vim.fn.executable("yapf") == 1 or vim.fn.executable("yapf3") == 1 then
  if vim.fn.findfile(".style.yapf", ".;") ~= "" then
    local python_auto_format_group = vim.api.nvim_create_augroup("PythonAutoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.py",
      callback = function()
        local p = vim.fn.getpos(".")
        if vim.fn.executable("yapf") == 1 then
          vim.cmd(':silent exec "%!yapf"')
        end
        if vim.fn.executable("yapf3") == 1 then
          vim.cmd(':silent exec "%!yapf3"')
        end
        vim.fn.setpos(".", p)
      end,
      group = python_auto_format_group,
    })
  end
end
