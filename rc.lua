--###
--# awesome config by Gabriel "dunz0r" Fornaeus
--
-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Dynamic tagging with shifty
require("lib/shifty")
-- MPD-library
require("lib/mpd")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- Just link your theme to ~/.awesome_theme
theme_path = os.getenv("HOME") .. "/.awesome_theme"

-- Actually load theme
beautiful.init(theme_path)

-- Default applications
terminal = "urxvtc"
-- Which browser
browser = "firefox"
-- where to paste stuff
pastebin = os.getenv("HOME") .. ".pastebin"
-- What is used to paste stuff
pastecommand = "xclip -o >> " .. pastebin
-- this is the default level when adding a todo note
todo_level = "high"
-- What should we use to lock the display?
locker = "vlock -n" or "xscreensaver-command -lock"
-- Default modkey.                                                l
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["Xmessage"] = true,
    ["Wireshark"] = true,
    ["XBoard"] = true,
    ["feh"] = true,
    ["Wicd-client.py"] = true,
    ["gimp"] = true,
    ["XCalc"] = true,
    ["display"] = true,
    ["Preferences"] = true,
    ["XClipboard"] = true,
    ["Imagemagick"] = true,
    ["Snes9X"] = true,
    ["Add-ons"] = true
}
-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
--[[
apptags =
{
    ["Gran Paradiso"] = { screen = 1, tag = 2 },
    ["Xchm"] = { screen = 1, tag = 3 },
    ["apvlv"] = { screen = 1, tag = 3 },
    ["FBReader"] = { screen = 1, tag = 3 },
}
--]]
-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

--{{{ Shifty

shifty.config.defaults = {
  layout = "tile.top",
}
shifty.config.tags = {
   ["1:irc"] = { position = 1, screen = 1,                                            },
   ["2:www"] = { exclusive = true, solitary = true, position = 2, spawn = browser,    },
  ["3:term"] = { persist = true, position = 3, mwfact = 0.60, layout = "tile",        },
  ["4:vim"]  = { position = 4, nopopup = true, layout = "tile.top",                   },
  ["ncmpcpp"] = { nopopup = true, leave_kills = true,                                 },
     ["p2p"] = { icon = "/usr/share/pixmaps/p2p.png", icon_only = true,               },
    ["gimp"] = { layout = "tile", mwfact = 0.18, icon="/usr/share/pixmaps/gimp.png",  },
      ["fs"] = { rel_index = 1,                                                       },
}

shifty.config.apps = {
        { match = { "Irssi",        }, tag = "1:irc",        screen = 1,     },
        { match = {"Gran Paradiso.*", ".*Vimperator"       }, tag = "2:www",                        },
        { match = {"urxvt"                          }, tag = "3:term",       screen = 1,     },
        { match = {"term:.*"                          }, tag = "3:term",       screen = 1,     },
        { match = {".*- VIM"                          }, tag = "4:vim",       screen = 1,     },
        { match = {"ncmpcpp",             }, tag = "ncmpcpp",                       },
        { match = {"Live.*",                        }, tag = "live",         nopopup = true, },
        { match = {"Deluge","rtorrent"              }, tag = "p2p",                          },
        { match = {"Gimp","Ufraw"                   }, tag = "gimp",                         },
        { match = {"gimp-image-window"              }, slave = true,                         },
        { match = {"gqview"                         }, tag = "gqview",                       },
        { match = { "mc"                       }, tag = "fs",                           },
        { match = {"gcolor2", "xmag"                }, intrusive = true,                     },
        { match = {"gcolor2"                        }, geometry = { 100,100,nil,nil },       },
        { match = {"recordMyDesktop", "MPlayer", "xmag", 
                                                    }, float = true,                         },
        { match = { "" }, buttons = {
                             button({ }, 1, function (c) client.focus = c; c:raise() end),
                             button({ modkey }, 1, function (c) awful.mouse.client.move() end),
                             button({ modkey }, 3, awful.mouse.client.resize ), }, },
}


shifty.init()
-- }}}

-- {{{ Wibox
-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
bwibox = {}
mypromptbox = {}
mylayoutbox = {}
batterybox = {}
mpdbox = {}
batbar = {}
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
                      shifty.taglist = mytaglist
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c) client.focus = c; c:raise() end),
                       button({ }, 3, function () awful.menu.clients({ width=250 }) end),
                       button({ }, 4, function () awful.client.focus.byidx(1) end),
                       button({ }, 5, function () awful.client.focus.byidx(-1) end) }

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox" })

-- Create a batterybox widget
batterybox = widget({ type = "textbox" })
-- Create an info box
infobox = widget({ type = "textbox", align = "left" })
-- Create a box for mpd
mpdbox = widget({ type = "textbox", align = "left" })
-- Create a bar for battery
batbar = widget({type = 'progressbar', name = 'batbar' })
batbar.width = 60
batbar.height = 0.45
batbar.gap = 1
batbar.border_width = 1
batbar.border_padding = 0
batbar.ticks_count = 10
batbar.ticks_gap = 1
batbar:bar_properties_set('bat', {

bg = beautiful.fg_urgent,
fg = "red",
fg_center = "yellow",
fg_end = "green",
reverse = false,
min_value = 0,
max_value = 100
})
-- Create a datebox widget
datebox = widget({ type = "textbox", align = "right" })
tbox = widget({ type = "textbox", align = "right" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)
        -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)

    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
			   mypromptbox[s],
			   mpdbox,
			   infobox,
			   batterybox,
			   batbar,
         mytaglist[s],
			   datebox,
			   mysystray
		}
    mywibox[s].screen = s
    -- Create the bottom wibox
    bwibox = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    	bwibox.widgets = {
			mylayoutbox[s],
			mytasklist[s]
		  }
	bwibox.screen = s

end
--}}}

--{{{ Load files
-- Load functions
loadfile(awful.util.getdir("config") .. "/functions.lua")()

-- load keybindings
loadfile(awful.util.getdir("config") .. "/keybindings.lua")()

-- load hooks
loadfile(awful.util.getdir("config") .. "/hooks.lua")()
--}}}
-- vim: foldmethod=marker:filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:encoding=utf-8:textwidth=80
