local wezterm = require("wezterm")
local act = wezterm.action
local act_cb = wezterm.action_callback
local session_manager = require("wezterm-session-manager/session-manager")

-- Helper function to check if current process is Neovim
local function is_nvim(pane)
  local process_name = pane:get_foreground_process_name()
  return process_name and process_name:find("nvim") ~= nil
end

-- session-manager
wezterm.on("save_session", function(window)
  session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
  session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
  session_manager.restore_state(window)
end)

-- Main config
local config = {
  font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),
  font_size = 12.0,
  color_scheme = "Tokyo Night",
  adjust_window_size_when_changing_font_size = false,

  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_max_width = 30,

  enable_scroll_bar = false,
  window_background_opacity = 0.99,

  keys = {
    -- <CTRL-SHIFT-E> Rename Tab
    {
      key = "E",
      mods = "CTRL|SHIFT",
      action = act.PromptInputLine({
        description = "Enter new name for tab",
        action = act_cb(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    },
    -- <CMD-W> Close Tab or Neovim buffer
    {
      key = "w",
      mods = "CMD",
      action = act_cb(function(window, pane)
        if is_nvim(pane) then
          return window:perform_action(
            act.SendString("\x1b bd"), -- leader
            pane
          )
        else
          window:perform_action(act.CloseCurrentTab({ confirm = true }), pane)
        end
      end),
    },
    -- <CMD-S> Save Neovim buffer
    {
      key = "s",
      mods = "CMD",
      action = act_cb(function(window, pane)
        if is_nvim(pane) then
          return window:perform_action(act.SendString("\x1b\x13"), pane)
        end
      end),
    },
    -- <CMD-SHIFT-D> Split Pane Vertically
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    -- <CMD-SHIFT-F> Split Pane Vertically
    {
      key = "f",
      mods = "CMD|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- <CMD-SHIFT-Z> Undo in Neovim
    {
      key = "z",
      mods = "CMD",
      action = act_cb(function(window, pane)
        if is_nvim(pane) then
          return window:perform_action(
            act.SendString("\x1bua"), -- leader
            pane
          )
        end
      end),
    },
    {
      key = "z",
      mods = "CTRL",
      action = act_cb(function(window, pane)
        if is_nvim(pane) then
          return window:perform_action(
            act.SendString("\x1bua"), -- leader
            pane
          )
        end
      end),
    },
    {
      key = "z",
      mods = "CMD|SHIFT",
      action = act_cb(function(window, pane)
        if is_nvim(pane) then
          return window:perform_action(
            act.SendString("\x1b\x12a"), -- leader
            pane
          )
        end
      end),
    },
    -- <CTRL-SHIFT-K> Clear Scrollback
    {
      key = "K",
      mods = "CTRL|SHIFT",
      action = act.ClearScrollback("ScrollbackAndViewport"),
    },
    {
      key = "S",
      mods = "CMD|SHIFT",
      action = act({ EmitEvent = "save_session" }),
    },
    {
      key = "L",
      mods = "CMD|SHIFT",
      action = act({ EmitEvent = "load_session" }),
    },
    {
      key = "R",
      mods = "CMD|SHIFT",
      action = act({ EmitEvent = "restore_session" }),
    },
  },
}

-- <CTRL+ALT> + number to move to that position
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL|CMD",
    action = wezterm.action.MoveTab(i - 1),
  })
end

return config
