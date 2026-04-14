local wezterm = require 'wezterm'
local config = wezterm.config_builder and wezterm.config_builder() or {}

local is_windows = wezterm.target_triple:find("windows") ~= nil

local act = wezterm.action

--
-- key
--
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'Enter', mods = 'SHIFT',        action = wezterm.action.SendString('\x1b[13;2u')}, -- claude に SHIFT+Enter を送る
  { key = 'Enter', mods = 'CTRL|SHIFT',   action = wezterm.action.SendString('\x1b[13;2u')}, -- claude に SHIFT+Enter を送る
  { key = 'c',     mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '"',     mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
  { key = '%',     mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  { key = 'o',     mods = 'LEADER',       action = act.ActivatePaneDirection 'Next' },
  { key = ';',     mods = 'LEADER',       action = act.ActivatePaneDirection 'Prev' },
  { key = 'o',     mods = 'LEADER|CTRL',  action = act.RotatePanes 'Clockwise' },
  { key = 's',     mods = 'LEADER',       action = act.ShowLauncherArgs { flags = 'WORKSPACES', title = 'Select workspace' } },
}

--
-- font (共通)
--
config.font = wezterm.font_with_fallback({
  { family = "HackGen Console NF" },
  { family = "SauceCodePro Nerd Font Mono" },
})
config.adjust_window_size_when_changing_font_size = false
config.treat_east_asian_ambiguous_width_as_wide = false
config.unicode_version = 14

--
-- IME (共通)
--
config.use_ime = true -- wezは日本人じゃないのでこれがないとIME動かない

--
-- common
--
config.color_scheme = "Wez"
config.hide_tab_bar_if_only_one_tab = true
config.exit_behavior = "Close"

--
-- OS別設定
--
if is_windows then
  config.font_size = 12.0
  config.warn_about_missing_glyphs = false
  config.default_prog = { "nyagos.exe", "--chdir", "C:/Projects" }
  config.launch_menu = {
    {
      label = "Nyagos",
      args = {"nyagos.exe"},
      cwd = "C:/Projects",
    },
    {
      label = "Powershell",
      args = {"powershell.exe"},
    },
    {
      label = "ssh taigei.local",
      args = {"ssh.exe", "taigei.local"},
    },
    {
      label = "ssh no-sinker01.ddns.net",
      args = {"ssh.exe", "no-sinker01.ddns.net"},
    },
    {
      label = "Bash",
      args = {"bash", "-l"},
    },
  }
  config.window_background_opacity = 0.93
  config.use_fancy_tab_bar = false
  config.window_padding = {
    left = 4,
    right = 4,
    top = 2,
    bottom = 2,
  }
  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.7,
  }
else -- macOS
  config.font_size = 16.0
  config.default_prog = { "zsh", "--login" }
  config.launch_menu = {
    {
      args = {"top"},
    },
    {
      label = "Bash",
      args = {"bash", "-l"},
    },
  }
  config.window_background_opacity = 0.85
  config.use_fancy_tab_bar = true

  -- tabline プラグイン（macOS のみ）
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
  tabline.set_theme('GruvboxDark')
  tabline.setup()
end

return config
