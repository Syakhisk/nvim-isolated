---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    event = { "LazyFile" },
    version = "v2.*",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim", config = function() end },

      -- Loader UI indicator for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- "hrsh7th/cmp-nvim-lsp",
      "saghen/blink.cmp",
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = false,
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   prefix = "●",
          --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          --   -- prefix = "icons",
          -- },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = Lib.constants.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = Lib.constants.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = Lib.constants.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = Lib.constants.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = false,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = true,
          exclude = { "lua" },
        },
        -- Enable this to enable the builtin LSP folding on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the folds.
        folds = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean}
        ---@type table<string, lazyvim.lsp.Config|boolean>
        servers = {
          stylua = { enabled = false },
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,

    ---@param opts PluginLspOpts
    config = vim.schedule_wrap(function(_, opts)
      Lib.lsp.setup()

      -- inlay hints
      if opts.inlay_hints.enabled then
        Lib.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype) then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- folds
      if opts.folds.enabled then
        Lib.lsp.on_supports_method("textDocument/foldingRange", function(client, buffer)
          vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local" })
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        Lib.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" and not vim.tbl_contains(opts.codelens.exclude, vim.bo[buffer].filetype) then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end)
      end

      -- diagnostics
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = Lib.constants.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      if opts.capabilities then
        vim.lsp.config("*", { capabilities = opts.capabilities })
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason = Lib.plugins.has("mason-lspconfig.nvim")
      local mason_all = have_mason and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package) or {} --[[ @as string[] ]]
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude automatic setup
      local function configure(server)
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts) -- configure the server
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end

      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      if have_mason then
        require("mason-lspconfig").setup({
          ensure_installed = vim.list_extend(install, Lib.plugins.opts("mason-lspconfig.nvim").ensure_installed or {}),
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end),
  },
}
