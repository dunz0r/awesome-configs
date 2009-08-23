--###
--# awesome config by Gabriel "dunz0r" F
--
-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Dynamic tagging with shifty
require("lib/shifty")
-- MPD library
require("lib/mpd") ; mpc = mpd.new()
-- Wicked
require("wicked")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- Just link your theme to ~/.awesome_theme
theme_path = os.getenv("HOME") .. "/.config/awesome/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- Default applications
terminal = "urxvtc"
-- Which browser
browser = "uzbl"
-- where to paste stuff
pastebin = os.getenv("HOME") .. ".pastebin"
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

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

--{{{ Shifty

shifty.config.defaults = {
  layout = "tiletop",
}
shifty.config.tags = {
   ["1:irc"] = { position = 1, spawn = "urxvtc -name SSH -title '::irssi::' -e ssh -C ninjaloot.se", },
   ["2:www"] = { exclusive = true, solitary = true, position = 2, layout = "max", nopopup = true, spawn = browser,    },
  ["3:term"] = { persist = true, position = 3, layout = "tiletop",        },
  ["4:vim"]  = { position = 4, nopopup = true, layout = "tiletop", screen = 1,        },
  ["5:ncmpcpp"] = { nopopup = true, persist = false, leave_kills = true, position = 5, screen = 2, spawn = "urxvtc -name '::ncmpcpp::' -title '::ncmpcpp::' -e ncmpcpp" },
  ["6:code"] = { persist = true, position = 6, layout = "tiletop",        },
     [":p2p"] = { icon = "/usr/share/pixmaps/p2p.png", icon_only = true, },
    [":gimp"] = { layout = "float", icon_only = true, mwfact = 0.18, sweep_delay = 2, exclusive = true, icon="/usr/share/pixmaps/gimp.png", screen = 1,  },
      [":fs"] = { rel_index = 1, exclusive = false                                           },
      [":Wine"] = { rel_index = 1, layout = "float", screen = 1, nopopup = true, },
      [":video"] = { layout = "float", screen = 1, },
      [":PDF"] = { layout = "tiletop", },
}

shifty.config.apps = {
        { match = { "::irssi.*",        }, tag = "1:irc",        screen = 2,     },
        { match = {"Shiretoko.*", "Vimperator.*", ".*uzbl"       }, tag = "2:www", nopopup = true,       },
        { match = {"urxvt"                          }, tag = "3:term",      },
        { match = {"term:.*"                          }, tag = "3:term",     },
        { match = {".*- VIM"                          }, tag = "6:code",      },
        { match = {"::ncmpcpp.*",             }, tag = "5:ncmpcpp",                       },
        { match = {"MPlayer.*",                        }, tag = ":video", },
        { match = {"MilkyTracker.*","Sound.racker.*"}, tag = ":TRACKZ",         nopopup = true, },
        { match = {".*Wine desktop.*"}, tag = ":Wine",         nopopup = true, },
        { match = {"Deluge","rtorrent"              }, tag = ":p2p",                          },
        { match = {"apvlv",                         }, tag = ":PDF"},
        { match = {"Xpdf.*",                         }, tag = ":PDF"},
        { match = {"Gimp","Ufraw"                   }, tag = ":gimp",                         },
        { match = { "gimp.toolbox",                     },  slave = true , struts = { right=200 },
                                                        geometry = {nil,35,200,733}                   },
        { match = {"gimp-image-window"              }, slave = true,                         },

        { match = {"feh.*"                         }, tag = ":feh",                       },
        { match = { "popterm",                          },  intrusive = true, struts = { bottom = 200 },
                                                        dockable = true, float = true, sticky = true  },
        { match = { "mc -.+"                       }, tag = ":fs:",                           },
        { match = {"gcolor2", "xmag"                }, intrusive = true,                     },
        { match = {"gcolor2"                        }, geometry = { 100,100,nil,nil },       },
        { match = {"recordMyDesktop", "MPlayer", "xmag", 
                                                    }, float = true,                         },
        { match = { "" }, buttons = {
                             button({ }, 1, function (c) client.focus = c; c:raise() end),
                             button({ modkey }, 1, function (c) awful.mouse.client.move() end),
                             button({ modkey }, 3, awful.mouse.client.resize ), }, },
}


-- tag defaults
shifty.config.defaults = {
  layout = awful.layout.suit.tile.top,
  ncol = 1,
  floatBars = true,
 }
shifty.config.layouts = layouts
shifty.init()
-- }}}

-- {{{ Widgets
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
cpuwidget = {}
cpugraphwdiget = {}
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
-- Create a cpuwidget
cpuwidget = widget({
      type = 'textbox',
          name = 'cpuwidget'
        })

        wicked.register(cpuwidget, wicked.widgets.cpu,
            '$1%')
-- Create a box for mpd
mpdbox = widget({ type = "textbox", align = "left" })
-- Create a bar for battery
batbar = widget({type = 'progressbar', name = 'batbar' })
batbar.width = 60
batbar.height = 0.45
batbar.gap = 1
batbar.border_width = 1
batbar.screen = 1
batbar.border_padding = 0
--batbar.ticks_count = 10
--batbar.ticks_gap = 1
batbar:bar_properties_set('bat', {

bg = beautiful.fg_urgent,
fg = "red",
fg_center = "yellow",
fg_end = "green",
reverse = false,
min_value = 0,
max_value = 100
})
-- Create a cpugraph widget
cpugraphwidget = widget({
    type = 'graph',
    name = 'cpugraphwidget'
})

cpugraphwidget.height = 0.6
cpugraphwidget.width = 45
cpugraphwidget.bg = '#171717'
cpugraphwidget.fg = '#333333'
cpugraphwidget.fg_end = '#1793d1'
cpugraphwidget.border_color = '#524E41'
cpugraphwidget.grow = 'left'
cpugraphwidget.screen = 1

cpugraphwidget:plot_properties_set('cpu', {
    fg = '#999999',
})

wicked.register(cpugraphwidget, wicked.widgets.cpu, '$1', 1, 'cpu')

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
--}}}

--{{{ Wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
			   mpdbox,
			   infobox,
			   batterybox,
			   batbar,
         cpuwidget,
         cpugraphwidget,
         mytaglist[s],
			   mypromptbox[s],
         datebox,
			   mysystray
		}
    mywibox[s].screen = s
    --the lower wibox
    bwibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    bwibox[s].widgets = {
        mylayoutbox[s],
        mytasklist[s]
    }
    bwibox[s].screen = s
end
--}}}

--{{{ Functions

-- get mpd info
--{{{ Get mpd info
function get_mpd()
  local stats = mpc:send("status")
  if stats.state == "stop" then
	 now_playing = " stopped"
  else
    local zstats = mpc:send("playlistid " .. stats.songid)
	  now_playing = ( zstats.album  or "NA" ) .. "; " .. ( zstats.artist or "NA" ) .. " - " .. (zstats.title or string.gsub(zstats.file, ".*/", "" ) )
	end
  if stats.state == "pause" then
    now_playing = "<span color='#505050'>" .. awful.util.escape(now_playing) .. "</span>"
  else
    now_playing = awful.util.escape(now_playing)
  end
  return now_playing .. " | "
end
--}}}

--{{{ Show playlist
function get_playlist ()
	local stats = mpc:send("status") 
	local cur = stats.song
  local list = ""
	for i = stats.song-4,stats.song+5
		do
		zstats = mpc:send("playlistinfo " .. i)
		if zstats.pos == stats.song then
			list = list .. "<span color='#FF0000'> " .. zstats.pos .. ". " .. zstats.artist .. " - " .. (zstats.title or zstats.file) .. "</span>\n"
		else
			list = list .. " " .. zstats.pos .. ". " .. zstats.artist .. " - " .. (zstats.title or zstats.file) .. "\n"
		end
	end
    return list
end
--}}}

--{{{ Add a todo note

	function addtodo (todo)
		infobox.text = "| <b><u>todo:</u></b> " .. "<span color='#FF00FF'>" .. awful.util.spawn("todo --add --priority high " .. "'" .. todo .. "'") .. "</span>"
	end
--}}}

--{{{ Shows batteryinfo for (adapter)
 function batteryinfo(adapter)

     local fcap = io.open("/sys/class/power_supply/" .. adapter .. "/energy_full")
     local fcur = io.open("/sys/class/power_supply/" .. adapter .. "/energy_now")
     local fsta = io.open("/sys/class/power_supply/" .. adapter .. "/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur / cap * 100)
     if sta:match("Charging") then
         dir = "+ "
      elseif sta:match("Discharging") then
         dir = "- "
       else
         dir = "= "
     end
     batterybox.text = " | " .. dir
     batbar:bar_data_add("bat",tonumber(battery) )
     fcur:close()
     fcap:close()
     fsta:close()
 end
 --}}}

--{{{ get loadaverage and temperature
function get_load_temp()
	local lf = io.open("/proc/loadavg")
	local tf = io.open("/proc/acpi/thermal_zone/THRM/temperature")
	
	local l = lf:read()
	local t = tf:read()

	local l = string.match(l, "%d+%.%d%d")
	local t = string.match(t, "%d+ C")
	lf:close()
	tf:close()

	return l .. " | " .. t .. " "
end
--}}}

--{{{ Show todos
    function show_todo()
        local todo = awful.util.pread("todo --mono")
        todo = naughty.notify({
            text = string.format(os.date("%a, %d %B %Y") .. "\n" .. todo),
            timeout = 6,
            width = 300,
        })
    end
--}}}

--{{{ Show paste
    function show_paste()
        local paste = selection()
        paste = naughty.notify({
            text = paste,
            timeout = 6,
            width = 300,
        })
    end
--}}}

--{{{ Paste to (pastefile) or pastebin
function paste (pastefile)
  bufcon = selection()
  pastefile = pastefile or pastebin
  file = io.open("/home/dunz0r/.pastefile", "a")
  file:write(bufcon)
  file:close()
  infobox.text = "wrote X buffer content to" .. pastefile
end
--}}}

--{{{ Open stuff with uzbl
function uzbl_prompt(prompt, text, socket, command)
      if command then
        -- if a command prefix is provided
        command = command .. ' '
      end
    awful.prompt.run({prompt=prompt, text=text},
        mypromptbox[mouse.screen],
        function(input)
            awful.util.spawn(string.format("uzblctrl -s '%s' -c '%s%s'", socket, command, input))
        end)
end
--}}}
--}}}

--{{{ Keybindings
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Bindings for shifty
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,  "Shift"  }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey,  "Shift"  }, "Right",  shifty.shift_next        ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey            }, "t",           function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Control" }, "t",           function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey            }, "r",           shifty.rename),
    awful.key({ modkey            }, "w",           shifty.delete),
    awful.key({ modkey, "Shift"   }, "o",      function() shifty.set(awful.tag.selected(mouse.screen), { screen = awful.util.cycle(screen.count() , mouse.screen + 1) }) end),
    awful.key({ modkey,           }, "p",      function() list = naughty.notify({
                                                          text = get_playlist(),
                                                          width = 300 }) end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    -- MPD Bindings
    awful.key({ modkey,           }, "z", function () mpc:previous() ; hook_mpd() end),
    awful.key({ modkey,           }, "x", function () mpc:toggle_play() ; hook_mpd() end),
    awful.key({ modkey,           }, "c", function () mpc:stop() ; hook_mpd() end),
    awful.key({ modkey,           }, "v", function () mpc:next() ; hook_mpd() end),
   -- Display the todo list
    awful.key({ modkey,           }, "d", function () show_todo() end),
   -- Paste content of the xbuffer
   awful.key({ modkey, "Shift"    }, "p", function () paste() end),
   awful.key({ modkey, "Control"  }, "p", function ()
      awful.prompt.run({ prompt = "Paste to: "},
      mypromptbox[mouse.screen],
      function (s) paste(s) infobox.text = "| <b><u>X-selection</u></b> pasted to <i>" .. s .. "</i>" end,
      awful.completion.shell) end),
  -- Lock the screen
    awful.key({ modkey,           }, "Scroll_Lock", function () awful.util.spawn(locker) end),

    awful.key({ modkey            }, "t",           function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Control" }, "t",           function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey            }, "r",           shifty.rename),
    awful.key({ modkey            }, "w",           shifty.del),
    awful.key({ modkey, "Control" }, "o",     function () shifty.set(awful.tag.selected(mouse.screen), { screen = awful.util.cycle(mouse.screen + 1, screen.count()) }) end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    -- add a todo
   awful.key({ modkey, "Shift" }, "d",
              function ()
                  awful.prompt.run({ prompt = "Add Todo Note: " },
                  mypromptbox[mouse.screen],
                  addtodo(t), t,
                  awful.util.getdir("cache") .. "/todos")
              end),
   awful.key({ modkey }, "F2",
              function ()
                  awful.prompt.run({ fg_cursor = 'orange', bg_cursor = beautiful.bg_normal,
                  ul_cursor = "single", prompt = "Run: " },
                  mypromptbox[mouse.screen],
                  awful.util.spawn, awful.completion.shell,
                  awful.util.getdir("cache") .. "/history")
              end),

    awful.key({ modkey }, "F4",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen],
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey }, "t", awful.client.togglemarked),
    awful.key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

for i=1,9 do
  
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i,
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i,
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i,
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end
-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
--}}}
--}}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout and beautiful["layout_" ..layout] then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

-- Hook called every minute, displays time and date
function hook_date ()
    datebox.text = "<big>" .. os.date(" %R ") .. "</big>" .. " <u>" .. os.date("%m-%d") .. "</u>"
end

-- Hook showing mpd info
function hook_mpd()
	mpdbox.text = get_mpd()
end
-- Hook for loadavg, temp and battery
function hook_info()
	infobox.text = get_load_temp()
  --batteryinfo("BAT0")
end

-- Set timers for the hooks
awful.hooks.timer.register(3, hook_mpd)
awful.hooks.timer.register(60, hook_date)
awful.hooks.timer.register(20, hook_info)
-- run some of the hooks so we don't have to wait
hook_date()
hook_info()
--}}}
-- vim: foldmethod=marker:filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:encoding=utf-8:textwidth=80
