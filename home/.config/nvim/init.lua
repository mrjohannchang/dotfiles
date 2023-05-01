-- Built-in {
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

  -- lua-based {
  use {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { { "kyazdani42/nvim-web-devicons" } },
  }

  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-cmdline" }
  -- use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/vim-vsnip" }

  -- use { "neovim/nvim-pconfig" }

  use {
    "ishan9299/nvim-solarized-lua",
    config = "vim.cmd[[colorscheme solarized]]",
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  -- }

  -- vim-based {
  use { "junegunn/vim-easy-align" }
  use { "tpope/vim-surround" }
  -- }

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


-- lualine.nvim {
require "lualine".setup {
  options = { theme  = "solarized_light" },
}
-- }


-- nvim-cmp {
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'
cmp.setup({
  -- snippet = {
  --   -- REQUIRED - you must specify a snippet engine
  --   expand = function(args)
  --     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  --     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --   end,
  -- },
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
    -- { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
-- }


-- nvim-solarized-lua {
vim.g.solarized_termtrans = 1
-- }


-- telescope.nvim {
vim.api.nvim_set_keymap(
  "n", "<LEADER>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n", "<LEADER>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n", "<LEADER>fb", "<CMD>lua require('telescope.builtin').buffers({ sort_mru = true })<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n", "<LEADER>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- ..
    mappings = {
      n = {
        ['<ESC>'] = false,
        ['dd'] = require('telescope.actions').delete_buffer,
        ['q'] = require('telescope.actions').close,
      },
    },
  },
}
-- }


-- vim-easy-align {
vim.api.nvim_set_keymap("v", "<ENTER>", ":EasyAlign<CR>", { noremap = true })
-- }


-- Neovide {
vim.cmd("set guifont=Hack\\ NF:h10.2")
-- }


-- Load config for light background if available {
pcall(require, "init-light")
-- }


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- }
