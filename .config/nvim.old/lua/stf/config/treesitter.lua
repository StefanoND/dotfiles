-- Must install LLVM https://github.com/llvm/llvm-project/releases
-- GCC doesn't work (even scoop's one)
if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1 then
  require("nvim-treesitter.install").compilers = { "clang" }
end

local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    -- "maintained",
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "c_sharp",
    "gdscript",
    "godot_resource",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "json",
    "lua",
    "llvm",
    "make",
    "markdown",
    "markdown_inline",
    "org",
    "query",
    "rust",
    "sql",
    "vim",
    "vimdoc",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- autotagging from nvim-ts-autotag plugin
  autotag = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  -- Syntax highlighting
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require("ts_context_commentstring").setup()
