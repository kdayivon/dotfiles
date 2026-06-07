local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.max_fps = 144
config.font = wezterm.font("JetBrainsMono Nerd Font") 
config.window_frame = {
    font = wezterm.font({ family = "JetBrainsMono Nerd Font"}),
	active_titlebar_bg = "#0c0b0f",
} 
config.window_background_opacity = 0.9
config.window_decorations = "NONE | RESIZE"
config.font_size = 16.0
config.window_padding = {
    left = 0,
	right = 0,
	top = 5,
	bottom = 0,
}
config.line_height = 1.1
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- colors 
config.color_scheme = 'Gruvbox light, soft (base16)'

-- hotkeys
config.keys = {
	{
        key = 't',
		mods = 'CTRL',
		action = act.SpawnTab 'CurrentPaneDomain',
	},
	{
		key = 'w',
		mods = 'CTRL',
		action = act.CloseCurrentTab { confirm = false },
	},
	{
		key = 'n',
        mods = 'CTRL',
        action = act.ActivateTabRelative(-1),
    },
}

return config
