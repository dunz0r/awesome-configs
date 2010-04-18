---------------------------
-- dunz0rs awesome theme --
---------------------------

theme = {}

theme.font          = "Monaco 7"

theme.bg_normal     = "#0a0a0a"
theme.bg_focus      = "#3e3e3e"
theme.bg_urgent     = "#303030"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#898989"
theme.fg_focus      = "#c8c8c8"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#0a0a0a"
theme.border_focus  = "#3e3e3e"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/defualt/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/defualt/taglist/squaref.png"
theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/default/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
theme.wallpaper_cmd         = {"Esetroot -m .wallpaper"}
-- }}}

-- {{{ Layout
theme.layout_tile       = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_fairv      = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_fairh      = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_spiral     = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/default/layouts/dwindlew.png"
theme.layout_max        = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_floating   = "/usr/share/awesome/themes/default/layouts/floatingw.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}
theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
