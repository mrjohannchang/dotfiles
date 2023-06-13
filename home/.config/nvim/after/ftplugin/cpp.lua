if vim.fn.executable("clang-format") == 1 then
  if vim.fn.findfile(".clang-format", ".;") ~= "" then
    local cpp_auto_format_group = vim.api.nvim_create_augroup("CppAutoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.cpp", "*.cxx", "*.cc", ".h", "*.hpp", "*.hxx", "*.hh" },
      callback = function()
        local p = vim.fn.getpos(".")
        vim.cmd(":silent exec '!clang-format -i %'")
        vim.fn.setpos(".", p)
      end,
      group = cpp_auto_format_group,
    })
  end
end
