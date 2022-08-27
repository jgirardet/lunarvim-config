if vim.loop.os_uname().name == "WINDOWS_NT" then

  -- Enable powershell as your default shell
  vim.opt.shell = "pwsh.exe -NoLogo"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

  --   -- Set a compatible clipboard manager
  --   vim.g.clipboard = {
  --     copy = {
  --       ["+"] = "win32yank.exe -i --crlf",
  --       ["*"] = "win32yank.exe -i --crlf",
  --     },
  --     paste = {
  --       ["+"] = "win32yank.exe -o --lf",
  --       ["*"] = "win32yank.exe -o --lf",
  --     },
  --   }
end
-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":wa<cr>"
lvim.keys.normal_mode["²"] = "<ESC>:w<cr>"
lvim.keys.insert_mode["<F3>"] = "<ESC>:w<cr>"
lvim.keys.normal_mode["&"] = "<ESC>:w<CR>:ToggleTerm<CR>"
lvim.keys.visual_mode["ù"] = "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
lvim.keys.normal_mode["ù"] = "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>"
lvim.keys.normal_mode["mù"] =
"vip<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
lvim.keys.normal_mode["§"] = "<ESC><CMD>ToggleTerm<CR>"
lvim.keys.normal_mode["é"] = "<ESC><CMD>Telescope buffers<CR>"
lvim.keys.normal_mode["ç"] = "<ESC>:b#<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings[","] = { "<ESC><CMD>:bprev<CR>", "Buffer Prev" }
lvim.builtin.which_key.mappings[";"] = { "<ESC><CMD>:bnext<CR>", "Buffer Next" }

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.renderer.icons.git_placement = "signcolumn"
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "html",
  "javascript",
  "json",
  "lua",
  "python",
  "sql",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "toml",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = {}
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "css",
  "json",
  "lua",
  "python",
  "rust",
  "toml",
  "typescript",
  "yaml"
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  --   { command = "isort", filetypes = { "python" } },
  {
    --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    --     ---@usage arguments to pass to the formatter
    --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "tpope/vim-fugitive" },
  { "navarasu/onedark.nvim" },
  { "kylechui/nvim-surround" },
  { 'lourenci/github-colors' },
  { "karb94/neoscroll.nvim" },
  { "ellisonleao/dotenv.nvim" },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
  { 'folke/lsp-colors.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'p00f/nvim-ts-rainbow' },
  {
    "norcalli/nvim-colorizer.lua"
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "npxbr/glow.nvim"
  },
  {
    "lukas-reineke/indent-blankline.nvim", { event = "BufRead" }
  },
  {
    'ericpubu/lsp_codelens_extensions.nvim',
    -- Only required for debugging
    requires = { { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" } }
  },
  { 'liuchengxu/vim-clap' }
  -- {
  --   "olimorris/persisted.nvim",
  --   --module = "persisted", -- For lazy loading
  --   config = function()
  --     require("persisted").setup()
  --     require("telescope").load_extension("persisted") -- To load the telescope extension
  --   end,
  -- }

  -- {
  --   "folke/trouble.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  -- { "kelly-lin/telescope-ag", requires = { "nvim-telescope/telescope.nvim" } }
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "TroubleToggle",
  --     },
}

require("nvim-surround").setup()
-- require("neoscroll").setup()
require('onedark').setup {
}
require("diffview").setup {
  enhanced_diff_hl = true
}
require("colorizer").setup({ "css", "scss", "html", "javascript", "python" }, {
  RGB = true, -- #RGB hex codes
  RRGGBB = true, -- #RRGGBB hex codes
  RRGGBBAA = true, -- #RRGGBBAA hex codes
  rgb_fn = true, -- CSS rgb() and rgba() functions
  hsl_fn = true, -- CSS hsl() and hsla() functions
  css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})
require("glow").setup({})
require("indent_blankline").setup {
  show_current_context = true

  -- event = "BufRead",
  --   vim.g.indentLine_enabled = 1
  --   vim.g.indent_blankline_char = "▏"
  --   vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
  --   vim.g.indent_blankline_buftype_exclude = { "terminal" }
  --   vim.g.indent_blankline_show_trailing_blankline_indent = false
  --   vim.g.indent_blankline_show_first_indent_level = false
  -- end

}
require("codelens_extensions").setup()


-- should be set after the imports
vim.g.tokyonight_style = "night"
lvim.colorscheme = "tokyonight"

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- builtin plugins
-- require("nvim-treesitter.configs").setup(
-- { rainbow = { enable = true, extended = true } })
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.nvimtree.setup.git.ignore = true
