if vim.fn.executable("clang-format") == 1 then
  if vim.fn.findfile(".clang-format", ".;") ~= "" then
    local c_auto_format_group = vim.api.nvim_create_augroup("CAutoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.c", ".h" },
      callback = function()
        local p = vim.fn.getpos(".")
        vim.cmd(':silent exec "%!clang-format"')
        vim.fn.setpos(".", p)
      end,
      group = c_auto_format_group,
    })
  end
end
