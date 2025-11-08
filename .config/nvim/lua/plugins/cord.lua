return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    config = function()
      require("cord").setup({
        text = {
          editing = function(opts)
            local lang, icon = unpack(require("utils.cord_lang").get_language(opts.filename or ""))
            local article = (lang:match("^[AaEeIiOoUu]") and "an") or "a"
            if lang == "Unknown" then
              return "Editing file"
            end
            return string.format("%s Editing %s %s file", icon, article, lang)
          end,
          viewing = function(opts)
            local lang, icon = unpack(require("utils.cord_lang").get_language(opts.filename or ""))
            local article = (lang:match("^[AaEeIiOoUu]") and "an") or "a"
            if lang == "Unknown" then
              return "Viewing file"
            end
            return string.format("%s Viewing %s %s file", icon, article, lang)
          end,
          workspace = function(opts)
            return "🧠 In " .. (opts.workspace or "workspace")
          end,
        },
        idle = {
          enabled = false,
          timeout = 300000,
          show_status = true,
          ignore_focus = true,
          unidle_on_focus = true,
          smart_idle = true,
          details = "Idling",
          state = nil,
          tooltip = "💤",
          icon = nil,
        },
      })
    end,
  },
}
