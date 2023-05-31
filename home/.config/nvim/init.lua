-- Built-in {
-- https://github.com/nvim-tree/nvim-tree.lua {
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- }

vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

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


-- Workarounds {
-- https://github.com/neovim/neovim/issues/6660
if vim.loop.os_uname().sysname == "Windows" then
  vim.keymap.set("", "<C-z>", "", { noremap = true })
end
-- } Workarounds


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

  { "neovim/nvim-lspconfig" },

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
    "ishan9299/nvim-solarized-lua",
    config = function()
      vim.cmd.colorscheme("solarized")
      vim.g.solarized_termtrans = 1
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<LEADER>tf", "<CMD>NvimTreeOpen<CR>", { noremap = true })
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
      vim.keymap.set('n', '{', '<CMD>AerialPrev<CR>', { noremap = true })
      vim.keymap.set('n', '}', '<CMD>AerialNext<CR>', { noremap = true })
      vim.keymap.set("n", "<LEADER>ts", "<CMD>AerialOpen<CR>", { noremap = true })
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  { "mfussenegger/nvim-dap" },
  { "jay-babu/mason-nvim-dap.nvim" },
  { "mfussenegger/nvim-lint" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "mhartington/formatter.nvim" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  { "simrat39/rust-tools.nvim" },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- }

  -- VimScript-based {
  {
    "github/copilot.vim",
    build = ":Copilot setup",
  },

  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("v", "<ENTER>", "<CMD>EasyAlign<CR>", { noremap = true })
    end,
  },

  { "tpope/vim-surround" },

  -- {
  --   "fatih/vim-go",
  --   build = {
  --     ":GoInstallBinaries",
  --     ":GoUpdateBinaries",
  --   },
  -- },
  -- }
})
-- } Plugins


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
-- } Better command-line editing


-- Toggle paste mode with <F2> {
-- https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
vim.keymap.set("n", "<F2>", "<CMD>set invpaste paste?<CR>", { noremap = true })
vim.opt.pastetoggle="<F2>"

-- Leave paste mode on leaving insert mode
vim.api.nvim_command("autocmd InsertLeave * set nopaste")
-- } Toggle paste mode with <F2>


-- lspconfig {
-- mason.nvim {
require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
})
-- } mason.nvim
-- } lspconfig


-- GitHub Copilot {
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-e>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false })
-- } GitHub Copilot


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
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Setup LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp

-- Golang {
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require('lspconfig').gopls.setup{
  cmd = {'gopls'},
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
}
-- } Golang
-- Rust {
local lsp_attach = function(client, buf)
  -- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
  -- or a plugin like which-key.nvim
  -- <lhs>        <rhs>                        <desc>
  -- "K"          vim.lsp.buf.hover            "Hover Info"
  -- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
  -- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
  -- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
  -- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
  -- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
  -- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
  -- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
  -- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
  -- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"

  vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
  server = {
    capabilities = capabilities,
    on_attach = lsp_attach,
  },
})
-- } Rust
-- } nvim-cmp


-- telescope.nvim {
vim.keymap.set(
  "n", "<LEADER>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.keymap.set(
  "n", "<LEADER>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.keymap.set(
  "n", "<LEADER>fb", "<CMD>lua require('telescope.builtin').buffers({ sort_mru = true })<CR>", { noremap = true })
vim.keymap.set(
  "n", "<LEADER>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })

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
})
-- } telescope.nvim


-- Load config for light background if available {
pcall(require, "init-light")
-- } Load config for light background if available


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- } Reference
