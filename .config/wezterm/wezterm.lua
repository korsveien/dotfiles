-- https://wezfurlong.org/wezterm/config
local wezterm = require 'wezterm'

return {
    color_scheme = "Gruvbox dark, hard (base16)",
    font_size = 16.0,
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    pane_focus_follows_mouse = true,

    initial_rows = 50,
    initial_cols = 90,

    keys = {
        {
            key = 'Return',
            mods = 'CMD',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, 
        },
        {
            key = 'Return',
            mods = 'CMD|CTRL',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, 
        },
        { key = "h", mods = "CMD", action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "j", mods = "CMD", action=wezterm.action{ActivatePaneDirection="Down"}},
        { key = "k", mods = "CMD", action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "l", mods = "CMD", action=wezterm.action{ActivatePaneDirection="Right"}},
    },

    colors = {
        cursor_fg = 'black',
    };

    send_composed_key_when_left_alt_is_pressed = true,
    send_composed_key_when_right_alt_is_pressed = false,
}
