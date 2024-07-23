-- -- Built-in {
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.fileformats = "unix,dos"

vim.opt.hlsearch = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "░" }

vim.opt.number = true

vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.wrap = false

vim.opt.mouse = ""
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


-- Plugins and Plugin Configurations {
-- Plugins {
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Lua-based {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme  = "solarized_light" },
      })
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "ishan9299/nvim-solarized-lua",
    config = function()
      vim.cmd.colorscheme("solarized")
      vim.g.solarized_termtrans = 1
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "smartpde/telescope-recent-files",
    },
    config = function()
      vim.keymap.set("n", "<LEADER>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fh", "<CMD>lua require('telescope.builtin').find_files({ hidden = true })<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fw", "<CMD>lua require('telescope.builtin').grep_string()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fb", "<CMD>lua require('telescope.builtin').buffers({ sort_mru = true })<CR>", { noremap = true })

      require("telescope").load_extension("undo")
      require("telescope").load_extension("recent_files")

      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          -- ..
          mappings = {
            n = {
              ["<ESC>"] = false,
              ["dd"] = require("telescope.actions").delete_buffer,
              ["q"] = require("telescope.actions").close,
            },
          },
        },
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
        vim.keymap.set("n", "<LEADER>fu", "<CMD>lua require('telescope').extensions.undo.undo()<CR>", { noremap = true }),
        vim.keymap.set("n", "<LEADER>fr", "<CMD>lua require('telescope').extensions.recent_files.pick()<CR>", { noremap = true }),
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.g.indent_blankline_enabled = false
      vim.keymap.set("n", "<LEADER>|", "<CMD>IndentBlanklineToggle<CR>", { silent = true, noremap = true })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      vim.keymap.set(
      "n", "<LEADER>xx", "<CMD>TroubleToggle<CR>", { silent = true, noremap = true })
      -- vim.keymap.set(
      --   "n", "<LEADER>xw", "<CMD>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
      -- vim.keymap.set(
      --   "n", "<LEADER>xd", "<CMD>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
      -- vim.keymap.set(
      --   "n", "<LEADER>xl", "<CMD>TroubleToggle loclist<CR>", { silent = true, noremap = true })
      -- vim.keymap.set(
      --   "n", "<LEADER>xq", "<CMD>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
      vim.keymap.set(
      "n", "gR", "<CMD>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = { enabled = true },
        },
        buffers = {
          follow_current_file = { enabled = true },
        },
      })
      vim.keymap.set("n", "<LEADER>wf", "<CMD>Neotree position=right<CR>", { noremap = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
      vim.keymap.set("n", "{", "<CMD>AerialPrev<CR>", { noremap = true })
      vim.keymap.set("n", "}", "<CMD>AerialNext<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>ws", "<CMD>AerialOpen left<CR>", { noremap = true })
    end,
  },

  -- nvim-lsp dependent {
  { "neovim/nvim-lspconfig" },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  { "mfussenegger/nvim-dap" },
  { "jay-babu/mason-nvim-dap.nvim" },
  { "mfussenegger/nvim-lint" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()

      vim.keymap.set("n", "<LEADER>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/vim-vsnip",
    },
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = {  -- optional packages
      "neovim/nvim-lspconfig",
    },
    config = function()
      local rust_auto_format_group = vim.api.nvim_create_augroup("RustAutoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.buf.format()
        end,
        group = rust_auto_format_group,
      })
    end,
    ft = "rust",
  },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()

      local go_auto_format_group = vim.api.nvim_create_augroup("GoAutoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go", "*.go.mod" },
        -- command = "GoImport",
        callback = function()
          vim.lsp.buf.format()
        end,
        group = go_auto_format_group,
      })
    end,
    -- event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()", -- if you need to install/update all binaries
  },

  {
    "echasnovski/mini.align",
    config = function()
      require('mini.align').setup({
        mappings = {
          start = "",
          start_with_preview = "<CR>",
        },
      })
    end,
    version = false,
  },
  -- } nvim-lsp dependent
  -- } Lua-based

  -- VimScript-based {
  {
    "github/copilot.vim",
    build = ":Copilot setup",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-e>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false })
    end,
  },

  { "tpope/vim-surround" },
  -- } VimScript-based
})
-- } Plugins


-- lspconfig {
-- mason.nvim related {
require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
})

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({})
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
})
-- } mason.nvim related
-- } lspconfig


-- nvim-cmp {
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    -- { name = "vsnip" }, -- For vsnip users.
    -- { name = "luasnip" }, -- For luasnip users.
    -- { name = "ultisnips" }, -- For ultisnips users.
    -- { name = "snippy" }, -- For snippy users.
  }, {
    { name = "buffer" },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-e>"] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.close()
          cmp.complete()
        else
          fallback()
        end
      end
    },
  }),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Setup LSP {
local capabilities = require("cmp_nvim_lsp").default_capabilities() --nvim-cmp

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- C/C++ {
if vim.fn.executable("ccls") == 1 then
  if vim.fn.findfile("compile_commands.json", ".;") ~= "" or vim.fn.findfile(".ccls", ".;") ~= "" then
    require("lspconfig").ccls.setup({
      cmd = { "ccls" },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end
-- } C/C++

-- Golang {
require("lspconfig").gopls.setup({
  cmd = { "gopls" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
})
-- } Golang

-- Rust {
local rust_lsp_attach = function(client, buf)
  -- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
  -- or a plugin like which-key.nvim
  -- <lhs>        <rhs>                        <desc>
  -- "K"          vim.lsp.buf.hover            "Hover Info"
  -- "<LEADER>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
  -- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
  -- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
  -- "<LEADER>e"  vim.diagnostic.open_float    "Explain Diagnostic"
  -- "<LEADER>ca" vim.lsp.buf.code_action      "Code Action"
  -- "<LEADER>cr" vim.lsp.buf.rename           "Rename Symbol"
  -- "<LEADER>fs" vim.lsp.buf.document_symbol  "Document Symbols"
  -- "<LEADER>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
  -- "<LEADER>gq" vim.lsp.buf.formatting_sync  "Format File"

  vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
  server = {
    capabilities = capabilities,
    on_attach = rust_lsp_attach,
  },
})
-- } Rust
-- } Setup LSP
-- } nvim-cmp
-- } Plugins and Plugin Configurations


-- Load config for light background if available {
pcall(require, "init-light")
-- } Load config for light background if available


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- } Reference
