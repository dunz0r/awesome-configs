---------------------------
-- my awesome theme -------
---------------------------

theme = {}

theme.font = "Sans 7"
theme.tasklist_font = "Sans 7"
theme.titlebar_font = "Sans 7"

theme.bg_focus      = "#d0d0d0a0"
theme.bg_normal     = "#7f7f7f00"
theme.bg_urgent     = "#171717"

theme.fg_normal     = "#000000"
theme.fg_focus      = "#404040"
theme.fg_urgent     = "#ffc500"

theme.bg_widget     = "#ffffff"
theme.fg_widget     = "#c0c0c0"
theme.border_width  = 1
theme.border_normal = "#505050"
theme.border_focus  = "#c0c0c0"
theme.border_marked = "#91231c"

theme.widget_label = "#333333"
theme.widget_value = "#555555"

theme.help_font = "Monospace 6.5"
theme.help_highlight = theme.fg_urgent

theme.tasklist_floating_icon = "~/.config/awesome/icons/floating.png"

theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height   = 15
theme.menu_width    = 100


theme.wallpaper_cmd = { "feh --bg-tile /home/dunz0r/.wallpaper" }

theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairv.png"
theme.layout_floating = "/usr/share/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/max.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottom.png"
theme.layout_tileleft = "/usr/share/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletop.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
