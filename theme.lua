-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------


-- {{{ Main
theme   = {}
confdir = awful.util.getdir("config")
theme.wallpaper_cmd = { "/usr/bin/nitrogen --restore" }
--theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/zenburn/zenburn-background.png" }
-- }}}


-- {{{ Styles
theme.font      = "fixed 9"

-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#1E2320"
theme.bg_urgent = "#3F3F3F"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- theme.titlebar_[normal|focus]
-- }}}

-- {{{ Widgets
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = "#CC9393"
theme.bg_widget        = "#3F3F3F"
theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- theme.mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Tooltips
-- theme.tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- }}}

-- {{{ Taglist and Tasklist
-- theme.[taglist|tasklist]_[bg|fg]_[focus|urgent]
-- }}}

-- {{{ Menu
-- theme.menu_[height|width]
-- theme.menu_[bg|fg]_[normal|focus]
-- theme.menu_[border_color|border_width]
-- }}}
-- }}}


-- {{{ Icons
--
-- {{{ Taglist icons
theme.taglist_squares_sel   = confdir .. "/icons/taglist/squarefw.png"
theme.taglist_squares_unsel = confdir .. "/icons/taglist/squarew.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc icons
--theme.awesome_icon           = confdir .. "/icons/awesome.png"
--theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
--theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = confdir .. "/icons/layouts/tilew.png"
theme.layout_tileleft   = confdir .. "/icons/layouts/tileleftw.png"
theme.layout_tilebottom = confdir .. "/icons/layouts/tilebottomw.png"
theme.layout_tiletop    = confdir .. "/icons/layouts/tiletopw.png"
theme.layout_fairv      = confdir .. "/icons/layouts/fairvw.png"
theme.layout_fairh      = confdir .. "/icons/layouts/fairhw.png"
theme.layout_spiral     = confdir .. "/icons/layouts/spiralw.png"
theme.layout_dwindle    = confdir .. "/icons/layouts/dwindlew.png"
theme.layout_max        = confdir .. "/icons/layouts/maxw.png"
theme.layout_fullscreen = confdir .. "/icons/layouts/fullscreenw.png"
theme.layout_magnifier  = confdir .. "/icons/layouts/magnifierw.png"
theme.layout_floating   = confdir .. "/icons/layouts/floatingw.png"
-- }}}

-- {{{ Widget icons
theme.widget_cpu    = confdir .. "/icons/cpu.png"
theme.widget_bat    = confdir .. "/icons/bat.png"
theme.widget_mem    = confdir .. "/icons/mem.png"
theme.widget_fs     = confdir .. "/icons/disk.png"
theme.widget_net    = confdir .. "/icons/down.png"
theme.widget_netup  = confdir .. "/icons/up.png"
theme.widget_mail   = confdir .. "/icons/mail.png"
theme.widget_vol    = confdir .. "/icons/vol.png"
theme.widget_org    = confdir .. "/icons/cal.png"
theme.widget_date   = confdir .. "/icons/time.png"
theme.widget_crypto = confdir .. "/icons/crypto.png"
-- }}}

-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = confdir .. "/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = confdir .. "/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = confdir .. "/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = confdir .. "/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = confdir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = confdir .. "/icons/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}


return theme
