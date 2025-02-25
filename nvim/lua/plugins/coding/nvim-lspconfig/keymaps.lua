local M = {}

local remove_defaults = function()
  local maps = {
    { "n", "grn" },
    { "n", "gra" },
    { "x", "gra" },
    { "n", "grr" },
    { "n", "gri" },
    { "n", "gO" },
    { "i", "<C-S>" },
    { "s", "<C-S>" },
  }

  for _, v in pairs(maps) do
    vim.keymap.del(v[1], v[2])
  end
end

M.setup_on_attach = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
    callback = function(event)
      remove_defaults()
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      -- TODO: complete these
      map("gd", function()
        require("telescope.builtin").lsp_definitions({ reuse_win = false, show_line = false })
      end, "[G]oto [D]efinition")

      map("gr", function()
        require("telescope.builtin").lsp_references({ reuse_win = false, show_line = false, include_current_line = false })
      end, "[G]oto [R]eferences")

      map("gi", function()
        require("telescope.builtin").lsp_implementations({ reuse_win = false, show_line = false })
      end, "[G]oto [I]mplementation")

      map("gy", function()
        require("telescope.builtin").lsp_type_definitions({ reuse_win = false })
      end, "[G]oto T[y]pe definition")

      map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
      map("<C-S>", vim.lsp.buf.signature_help, "Signature help", { "i", "s" })

      -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      -- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      -- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      -- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
      -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      --
      -- local client = vim.lsp.get_client_by_id(event.data.client_id)
      -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      --   local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      --     buffer = event.buf,
      --     group = highlight_augroup,
      --     callback = vim.lsp.buf.document_highlight,
      --   })
      --
      --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      --     buffer = event.buf,
      --     group = highlight_augroup,
      --     callback = vim.lsp.buf.clear_references,
      --   })
      --
      --   vim.api.nvim_create_autocmd("LspDetach", {
      --     group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      --     callback = function(event2)
      --       vim.lsp.buf.clear_references()
      --       vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
      --     end,
      --   })
      -- end
      --
      -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      --   map("<leader>th", function()
      --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      --   end, "[T]oggle Inlay [H]ints")
      -- end
    end,
  })
end

return M
