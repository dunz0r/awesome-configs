---------------------------
-- my awesome theme -------
---------------------------

theme = {}

theme.font = "Sans 7"
theme.tasklist_font = "Sans 7"
theme.titlebar_font = "Sans 7"

theme.bg_focus      = "#606060aa"
theme.bg_normal     = "#7f7f7f00"
theme.bg_urgent     = "#171717"

theme.fg_normal     = "#309030"
theme.fg_focus      = "#00FF00"
theme.fg_urgent     = "#ffc500"

theme.bg_widget     = "#ffffff00"
theme.fg_widget     = "#FFC500"
theme.border_width  = 1
theme.border_normal = "#505050"
theme.border_focus  = "#40c040"
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

theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
