-- Built-in {
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.fileformats = "unix,dos"

vim.opt.hlsearch = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "░" }

vim.opt.number = true

vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.wrap = false

vim.opt.mouse = ""
vim.opt.background = "dark"

vim.opt.splitright = true  -- temporary for CopilotChat.nvim
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


-- Better buffer navigation {
-- Move to the previous buffer
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { noremap = true })
-- Move to the next buffer
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { noremap = true })
-- } Better buffer navigation


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


-- custom pre-init settings {
pcall(require, "custom-pre-init")
-- } custom pre-init settings


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
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
      vim.keymap.set("n", "{", "<CMD>AerialPrev<CR>", { noremap = true })
      vim.keymap.set("n", "}", "<CMD>AerialNext<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>ws", "<CMD>AerialOpen right<CR>", { noremap = true })
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 75,
          keymap = {
            accept = "<C-e>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = false,
          },
        },
      })
    end,
    event = "InsertEnter",
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
    -- version = "v2.11.0",
    -- Do not use branch and version together, either use branch or version
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      opts.prompts.Commit = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }

      chat.setup(opts)
      -- Setup the CMP integration
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          -- vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end,
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
    },
    event = "VeryLazy",
    keys = {
      -- Show help actions with telescope
      {
        "<leader>ah",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>ap",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      {
        "<leader>av",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ax",
        ":CopilotChatInline<cr>",
        mode = "x",
        desc = "CopilotChat - Inline chat",
      },
      -- Custom input for CopilotChat
      {
        "<leader>ai",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Generate commit message based on the git diff
      {
        "<leader>am",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>aM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      -- Quick chat with Copilot
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
      -- Copilot Chat Models
      { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
    },
    opts = {
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      prompts = {
        -- Code related prompts
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        FixCode = "Please fix the following code to make it work as intended.",
        FixError = "Please explain the error in the following text and provide a solution.",
        BetterNamings = "Please provide better names for the following variables and functions.",
        Documentation = "Please provide documentation for the following code.",
        SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
        SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
        -- Text related prompts
        Summarize = "Please summarize the following text.",
        Spelling = "Please correct any grammar and spelling errors in the following text.",
        Wording = "Please improve the grammar and wording of the following text.",
        Concise = "Please rewrite the following text to make it more concise.",
      },
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
      mappings = {
        -- Use tab for completion
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        -- Close the chat
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        -- Accept the diff
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = "gmy",
        },
        -- Show the diff
        show_diff = {
          normal = "gmd",
        },
        -- Show the prompt
        show_system_prompt = {
          normal = "gmp",
        },
        -- Show the user selection
        show_user_selection = {
          normal = "gms",
        },
        -- Show help
        show_help = {
          normal = "gmh",
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme  = "solarized_dark" },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
        },
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
    end,
    dependencies = {
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end,
      },
    },
  },

  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup({
        mappings = {
          start = "",
          start_with_preview = "|",
        },
      })
    end,
    version = false,
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
      vim.keymap.set("n", "<LEADER>wf", "<CMD>Neotree position=left<CR>", { noremap = true })
    end,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "nvim-tree/nvim-web-devicons" },  -- not strictly required, but recommended
      { "nvim-lua/plenary.nvim" },
    },
  },

  {
    "Tsuzat/NeoSolarized.nvim",
    config = function()
      vim.cmd.colorscheme("NeoSolarized")
    end,
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,  -- make sure to load this before all the other start plugins
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
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
          ["<C-n>"] = cmp.mapping(function(fallback)
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

          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
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
            end,
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/vim-vsnip" },
    },
    event = "InsertEnter",
  },

  {
    "mrjohannchang/nvim-config-local",
    config = function()
      require("config-local").setup({
        lookup_parents = true,     -- Lookup config files in parent directories
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    event = "VeryLazy",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      vim.keymap.set("n", "<LEADER>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fh", "<CMD>lua require('telescope.builtin').find_files({ hidden = true })<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fw", "<CMD>lua require('telescope.builtin').grep_string()<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>fb", "<CMD>lua require('telescope.builtin').buffers({ sort_mru = true })<CR>", { noremap = true })

      vim.keymap.set("n", "<LEADER>gd", "<CMD>lua require('telescope.builtin').lsp_definitions({ reuse_win = true })<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>gr", "<CMD>Telescope lsp_references<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>gi", "<CMD>lua require('telescope.builtin').lsp_implementations({ reuse_win = true })<CR>", { noremap = true })
      vim.keymap.set("n", "<LEADER>gy", "<CMD>lua require('telescope.builtin').lsp_type_definitions({ reuse_win = true })<CR>", { noremap = true })

      require("telescope").load_extension("undo")
      require("telescope").load_extension("recent_files")

      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          -- ..
          -- initial_mode = "normal",
          mappings = {
            n = {
              ["<ESC>"] = false,
              ["dd"] = require("telescope.actions").delete_buffer,
              ["q"] = require("telescope.actions").close,
              ["<C-c>"] = require("telescope.actions").close,
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
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
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "smartpde/telescope-recent-files" },
      { "debugloop/telescope-undo.nvim" },
    },
  },

  -- LSP related {
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<LEADER>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    }
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    config = function()
      require("lazydev").setup()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        command = "setlocal shiftwidth=2 softtabstop=2 tabstop=2"
      })
    end,
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
      { "williamboman/mason-lspconfig.nvim" },
    },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    keys = {
      {
        "<LEADER>xx",
        "<CMD>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<LEADER>xX",
        "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<LEADER>cs",
        "<CMD>Trouble symbols toggle focus=false<CR>",
        desc = "Symbols (Trouble)",
      },
      {
        "<LEADER>cl",
        "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<LEADER>xL",
        "<CMD>Trouble loclist toggle<CR>",
        desc = "Location List (Trouble)",
      },
      {
        "<LEADER>xQ",
        "<CMD>Trouble qflist toggle<CR>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
  -- } LSP related
})
-- } Plugins
-- } Plugins and Plugin Configurations


-- Load config for light background if available {
pcall(require, "init-light")
-- } Load config for light background if available


-- custom post-init settings {
pcall(require, "custom-post-init")
-- } custom post-init settings


-- Reference {
-- nvim/options.lua https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- nvim-lua-guide https://github.com/nanotee/nvim-lua-guide
-- } Reference
