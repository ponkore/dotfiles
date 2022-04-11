local wezterm = require 'wezterm';

return {
  font = wezterm.font("Ricty"), -- 自分の好きなフォントいれる
  use_ime = true, -- wezは日本人じゃないのでこれがないとIME動かない
  font_size = 16.0,
  color_scheme = "Wez", -- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  default_prog = {"zsh", "--login"},
  launch_menu = {
    {
      args = {"top"},
    },
    {
      label = "Bash",
      args = {"bash", "-l"},
    },
  },
  use_fancy_tab_bar = true,
  window_background_opacity = 0.85,
}
