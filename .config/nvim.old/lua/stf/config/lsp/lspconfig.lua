local lsp = require("lsp-zero")
lsp.extend_lspconfig()

lsp.preset("recommended")

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = "✘",
    warn = "▲",
    hint = "⚑",
    info = "»",
  },
})

lsp.setup()

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local cmpcapabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local util = require("lspconfig/util")

cmpcapabilities.textDocument.completion.completionItem.snippetSupport = true
cmpcapabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

lsp_defaults.capabilities = cmpcapabilities

local clangcapabilities = lsp_defaults
clangcapabilities.capabilities = {
  offsetEncoding = "utf-8",
  lsp_defaults.capabilities,
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- local on_attach = function(client, bufnr)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(client, bufnr)
    vim.cmd("TwilightEnable")
    local set = vim.keymap.set
    local opts = { buffer = bufnr, remap = false, silent = true }

    if client.name == "clangd" then
      client.server_capabilities.signatureHelpProvider = false
    end

    if client.name == "omnisharp" then
      set("n", "gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<CR>", opts)
      vim.api.nvim_command("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

      -- "Hacky, non-future-proof fix" - Arocci, Nicolai
      client.server_capabilities.semanticTokensProvider = {
        full = vim.empty_dict(),
        legend = {
          tokenModifiers = { "static_symbol" },
          tokenTypes = {
            "comment",
            "excluded_code",
            "identifier",
            "keyword",
            "keyword_control",
            "number",
            "operator",
            "operator_overloaded",
            "preprocessor_keyword",
            "string",
            "whitespace",
            "text",
            "static_symbol",
            "preprocessor_text",
            "punctuation",
            "string_verbatim",
            "string_escape_character",
            "class_name",
            "delegate_name",
            "enum_name",
            "interface_name",
            "module_name",
            "struct_name",
            "type_parameter_name",
            "field_name",
            "enum_member_name",
            "constant_name",
            "local_name",
            "parameter_name",
            "method_name",
            "extension_method_name",
            "property_name",
            "event_name",
            "namespace_name",
            "label_name",
            "xml_doc_comment_attribute_name",
            "xml_doc_comment_attribute_quotes",
            "xml_doc_comment_attribute_value",
            "xml_doc_comment_cdata_section",
            "xml_doc_comment_comment",
            "xml_doc_comment_delimiter",
            "xml_doc_comment_entity_reference",
            "xml_doc_comment_name",
            "xml_doc_comment_processing_instruction",
            "xml_doc_comment_text",
            "xml_literal_attribute_name",
            "xml_literal_attribute_quotes",
            "xml_literal_attribute_value",
            "xml_literal_cdata_section",
            "xml_literal_comment",
            "xml_literal_delimiter",
            "xml_literal_embedded_expression",
            "xml_literal_entity_reference",
            "xml_literal_name",
            "xml_literal_processing_instruction",
            "xml_literal_text",
            "regex_comment",
            "regex_character_class",
            "regex_anchor",
            "regex_quantifier",
            "regex_grouping",
            "regex_alternation",
            "regex_text",
            "regex_self_escaped_character",
            "regex_other_escape",
          },
        },
        range = true,
      }
    else
      set("n", "gd", "<cmd>lua vim.lsp.buf.definition()	<CR>", opts)
    end

    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()	<CR>", opts)
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()	<CR>", opts)
    set("n", "gw", "<cmd>lua vim.lsp.buf.document_symbol()	<CR>", opts)
    set("n", "gw", "<cmd>lua vim.lsp.buf.workspace_symbol()	<CR>", opts)
    set("n", "gr", "<cmd>lua vim.lsp.buf.references()	<CR>", opts)
    set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()	<CR>", opts)
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()	<CR>", opts)
    set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()	<CR>", opts)
    set("n", "<leader>af", "<cmd>lua vim.lsp.buf.code_action()	<CR>", opts)
    set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()	<CR>", opts)

    set("n", "[d", "<cmd>lua vim.diagnostic.goto_next()	<CR>", opts)
    set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()	<CR>", opts)
    set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()	<CR>", opts)

    set({ "n", "x" }, "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })	<CR>", opts)
  end,
})

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.lsp.start({
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    })
  end,
})

lspconfig.bashls.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello bash")
  end,
  capabilities = lsp_defaults,
})

lspconfig.clangd.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello C/C++")
  end,
  capabilities = clangcapabilities,
})

lspconfig.cmake.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello CMake")
  end,
  capabilities = lsp_defaults,
})

lspconfig.gdscript.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello Godot")
  end,
  capabilities = lsp_defaults,
})

lspconfig.jsonls.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello Json")
  end,
  capabilities = lsp_defaults,
})

lspconfig.lua_ls.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello Lua")
  end,
  capabilities = lsp_defaults,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  handlers = handlers,
  settings = {
    imports = {
      granularity = {
        group = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
  },
  on_attach = function(client, bufnr)
    print("Hello Rust")
  end,
  capabilities = lsp_defaults,
})

lspconfig.sqlls.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello SQL")
  end,
  capabilities = lsp_defaults,
})

lspconfig.yamlls.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    print("Hello Yaml")
  end,
  capabilities = lsp_defaults,
})

-- Omnisharp/C#/Unity
local pid = vim.fn.getpid()

-- Must be version 1.39.8, versions 1.39.9 - 1.39.11 (latest as of this writing) are causing issues:
--     "Error executing luv callback... Attempt to Index Local 'decoded' (a nil value)..."
-- Will update when this gets fixed (and if I remember)
local omnisharp_bin

if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1 then
  lspconfig.powershell_es.setup({
    bundle_path = "path/to/your/bundle_path",
    init_options = {
      enableProfileLoading = false,
    },
  })
  omnisharp_bin = os.getenv("UserProfile") .. "/AppData/Local/nvim/omnisharp-mono_1.39.8/OmniSharp.exe"
  vim.g.OmniSharp_server_use_mono = true
else -- I don't own/use a Mac, will update when/if I do
  omnisharp_bin = os.getenv("HOME") .. "/.config/nvim/omnisharp-linux-x64_1.39.8/run"
end

vim.g.OmniSharp_server_stdio = 1

lspconfig.omnisharp.enableImportCompletion = true

lspconfig.omnisharp.setup({
  use_mono = true,
  default_config = {
    filetypes = { "cs", "vb" },
    root_dir = function(fname)
      return util.root_pattern("*.sln")(fname) or util.root_pattern("*.csproj")(fname)
    end,
    on_new_config = function(new_config, new_root_dir)
      if new_root_dir then
        table.insert(new_config.cmd, "-s")
        table.insert(new_config.cmd, new_root_dir)
      end
    end,
    init_options = {},
  },
  enable_editorconfig_support = true,
  analyze_open_documents_only = false,
  enable_roslyn_analyzers = true,
  enable_import_completion = true,
  organize_imports_on_format = true,
  sdk_include_prereleases = false,
  handlers = vim.tbl_deep_extend("force", handlers, {
    ["textDocument/definition"] = vim.lsp.with(require("omnisharp_extended").handler, { border = "rounded" }),
  }),
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    print("Hello Omnisharp")
  end,
  capabilities = cmpcapabilities,
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
})

vim.diagnostic.config({
  virtual_text = true,
})
