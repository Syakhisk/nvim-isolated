---@type LazySpec
return {
  "folke/todo-comments.nvim",
  events = "LazyFile",
  opts = {
    keywords = {
      SAKIS = { icon = "", color = "error" },
      DANGER = { icon = " ", color = "error" },
      NOTE = { icon = "⏲ ", color = "note" },
      -- ["SAKIS:TODO"] = { icon = "", color = "blue" },
      -- ["SAKIS:INFO"] = { icon = "", color = "blue" },
      -- ["SAKIS:NOTE"] = { icon = "", color = "yellow" },
    },
    highlight = {
      multiline_pattern = "^ ",
    },
    colors = {
      -- TODO:colors
      note = { "WarningMsg", "#ffaf00" },
    },
  },
}
