-- Here is where you configure the autocompletion settings.
local lsp = require("lsp-zero")
lsp.extend_cmp()

-- And you can configure cmp even more, if you want to.
local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp_action = lsp.cmp_action()

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Do not jump to snippet if i'm outside of it
-- https://github.com/L3MON4D3/LuaSnip/issues/78
luasnip.config.setup({
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
})

-- load vs-code like snippets from plugins
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_git = require("cmp_git")
local format = require("cmp_git.format")
local sort = require("cmp_git.sort")

cmp_git.setup({
  -- defaults
  filetypes = { "gitcommit", "octo" },
  remotes = { "upstream", "origin" }, -- in order of most to least prioritized
  enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
  git = {
    commits = {
      limit = 100,
      sort_by = sort.git.commits,
      format = format.git.commits,
    },
  },
  github = {
    hosts = {}, -- list of private instances of github
    issues = {
      fields = { "title", "number", "body", "updatedAt", "state" },
      filter = "all", -- assigned, created, mentioned, subscribed, all, repos
      limit = 100,
      state = "open", -- open, closed, all
      sort_by = sort.github.issues,
      format = format.github.issues,
    },
    mentions = {
      limit = 100,
      sort_by = sort.github.mentions,
      format = format.github.mentions,
    },
    pull_requests = {
      fields = { "title", "number", "body", "updatedAt", "state" },
      limit = 100,
      state = "open", -- open, closed, merged, all
      sort_by = sort.github.pull_requests,
      format = format.github.pull_requests,
    },
  },
  gitlab = {
    hosts = {}, -- list of private instances of gitlab
    issues = {
      limit = 100,
      state = "opened", -- opened, closed, all
      sort_by = sort.gitlab.issues,
      format = format.gitlab.issues,
    },
    mentions = {
      limit = 100,
      sort_by = sort.gitlab.mentions,
      format = format.gitlab.mentions,
    },
    merge_requests = {
      limit = 100,
      state = "opened", -- opened, closed, locked, merged
      sort_by = sort.gitlab.merge_requests,
      format = format.gitlab.merge_requests,
    },
  },
  trigger_actions = {
    {
      debug_name = "git_commits",
      trigger_character = ":",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.git:get_commits(callback, params, trigger_char)
      end,
    },
    {
      debug_name = "gitlab_issues",
      trigger_character = "#",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.gitlab:get_issues(callback, git_info, trigger_char)
      end,
    },
    {
      debug_name = "gitlab_mentions",
      trigger_character = "@",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.gitlab:get_mentions(callback, git_info, trigger_char)
      end,
    },
    {
      debug_name = "gitlab_mrs",
      trigger_character = "!",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
      end,
    },
    {
      debug_name = "github_issues_and_pr",
      trigger_character = "#",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
      end,
    },
    {
      debug_name = "github_mentions",
      trigger_character = "@",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.github:get_mentions(callback, git_info, trigger_char)
      end,
    },
  },
})

cmp.setup({
  -- view = {
  --   entries = "native",
  -- },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end,
  completion = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
    completeopt = "menu,menuone,preview,noselect",
  },
  formatting = {
    fields = {
      cmp.ItemField.Abbr,
      cmp.ItemField.Kind,
      cmp.ItemField.Menu,
    },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = {
        Codeium = " ",
        Text = "󰉿 ",
        Method = "󰆧 ",
        Function = "󰊕",
        Constructor = " ",
        Field = "󰜢 ",
        Variable = "󰀫",
        Class = "󰠱 ",
        Interface = " ",
        Module = " ",
        Property = "󰜢 ",
        Unit = "󰑭 ",
        Value = "󰎠 ",
        Enum = " ",
        Keyword = "󰌋 ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈙 ",
        Reference = "󰈇 ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = "󰙅 ",
        Event = "",
        Operator = "󰆕 ",
        TypeParameter = "",
      },
      -- with_text = true,
      menu = {
        codeium = "[cod]",
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        git = "[git]",
        cmp_git = "[cmp_git]",
      },
      -- before = function(entry, vim_item)
      --   -- Get the full snippet (and only keep first line)
      --   local word = entry:get_insert_text()
      --   if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
      --     word = vim.lsp.util.parse_snippet(word)
      --   end
      --   word = str.oneline(word)
      --
      --   -- concatenates the string
      --   -- local max = 50
      --   -- if string.len(word) >= max then
      --   -- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
      --   -- 	word = before .. "..."
      --   -- end
      --
      --   if
      --     entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
      --     and string.sub(vim_item.abbr, -1, -1) == "~"
      --   then
      --     word = word .. "~"
      --   end
      --   vim_item.abbr = word
      --
      --   return vim_item
      -- end,
    }),
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
    },
    -- documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "codeium" },
    {
      name = "dap",
      -- name = function()
      --   if vim.bo.buftype == "*.cs" then
      --     return false
      --   end
      --   return "dap"
      -- end,
    },
    { name = "git" }, -- snippets
    { name = "cmp_git" }, -- snippets
    { name = "luasnip" }, -- snippets
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "neorg" },
    { name = "buffer", keyword_length = 2, max_item_count = 10 }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
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
    { name = "cmdline", keyword_length = 2 },
  }),
})
