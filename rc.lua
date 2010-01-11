		-- Standard awesome library
		require("awful")
		require("awful.autofocus")
		require("awful.rules")
		-- Theme handling library
		require("beautiful")
		-- Notification library
		require("naughty")
		-- Dynamic Tagging
		require("lib/shifty")
		-- MPD library
		require("lib/mpd") ; mpc = mpd.new()
		-- For sending to sockets
	--	socket = require"socket"
	--	socket.unix = require"socket.unix"
		-- {{{ Variable definitions
		-- Themes define colours, icons, and wallpapers
		theme_path = os.getenv("HOME") .. "/.config/awesome/theme.lua"
		beautiful.init(theme_path)

		-- This is used later as the default terminal and editor to run.
		terminal = "urxvtc"
		editor = os.getenv("EDITOR") or "vim"
		editor_cmd = terminal .. " -e " .. editor
		locker = "xlock"
		browser = "uzbl-browser"
		musicdir = "/home/dunz0r/warez/music/"
		-- where to paste
		pastebin = os.getenv("HOME") .. "/.pastebin"
		-- Default modkey.
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
			awful.layout.suit.spiral,
			awful.layout.suit.spiral.dwindle,
			awful.layout.suit.max,
			awful.layout.suit.max.fullscreen,
			awful.layout.suit.magnifier,
			awful.layout.suit.floating
		}
		-- Table of layouts to use on the 2:www tag
		wwwlayouts = 
		{
			awful.layout.suit.max,
			awful.layout.suit.fair
		}
		-- }}}

		-- {{{ Shifty
		shifty.config.defaults = {
		  layout = awful.layout.suit.tile.top, 
		  floatBars = true,
		 run = function(tag)
			 naughty.notify({ text = "Shifty Created "..
				 (awful.tag.getproperty(tag,"position") or shifty.tag2index(mouse.screen,tag)).." : "..
				 (tag.name or "foo")
				})
			end,
		  guess_name = true,
		  persist = false,
		  exclusive = true,
		  guess_position = true,
		  remember_index = true,
		  ncol = 1,
		  mwfact = 0.5,
		  nopopup = true
		}
		shifty.config.tags = {
		   ["1:irc"] = { position = 1, screen = 2, spawn = "urxvtc -tn screen.linux -name SSH -title '::irssi::' -e ssh -C dunz0r@10.0.0.1 -t screen -D -RR", },
		   ["2:www"] = { solitary = true, position = 2, max_clients = 5,
						 --[[keys = { 
								 awful.key({ "Ctrl" }, "y", function () awful.layout.set(awful.layout.suit.tile) end),
								 awful.key({ "Ctrl", "Shift" }, "y", function () awful.layout.set(awful.layout.suit.max) end),
								},
								--]]
						 exclusive = false, layout = awful.layout.suit.max, nopopup = true, spawn = "uzbl-browser",    },
		  ["3:term"] = { persist = true, position = 3, },
		  ["5:ncmpcpp"] = { nopopup = true, persist = false, position = 5, screen = 2, spawn = "urxvtc -name '::ncmpcpp::' -title '::ncmpcpp::' -e ncmpcpp" },
		  ["6:code"] = { spawn = terminal .. " -title '- VIM' -e " .. editor, nopopup = false, position = 6, layout = awful.layout.suit.max,        },
			 [":p2p"] = { icon = "/usr/share/pixmaps/p2p.png", icon_only = true, },
			[":gimp"] = { spawn = "gimp", layout = awful.layout.suit.max.fullscreen, sweep_delay = 2, screen = 1,  },
			[":gimp-tool"] = { layout = "tile", sweep_delay = 2, screen = 2,  },
			  [":fs"] = { rel_index = 1, exclusive = false                                           },
			  [":Wine"] = { rel_index = 1, layout = awful.layout.suit.float, screen = 1, nopopup = true, },
			  [":video"] = { nopopup = false, rel_index= 1, layout = awful.layout.suit.float, screen = 1, },
			  ["9:skype"] = { layout = awful.layout.suit.tile, screen = 2, mwfact = 0.6, position = 9, spawn = "skype-pulse", },
			  ["8:PDF"] = { layout = awful.layout.suit.fair, position = 8, nopopup = false },
			  [":img"] = { layout = awful.layout.suit.max.fullscreen, screen = 1, nopopup = false, spawn = "feh -F /home/dunz0r/gfx/*", },
			  ["cssh"] = { layout = awful.layout.suit.float, screen = 1, nopopup = false, exclusive = false, }
		}

		shifty.config.apps = {
			{ match = { "::irssi.*",                    }, tag = "1:irc", },
			{ match = {"Shiretoko.*", "Vimperator.*", "uzbl"       }, tag = "2:www" },
			{ match = {"urxvt"                          }, tag = "3:term",     },
			{ match = {"term:.*"                        }, tag = "3:term",     },
			{ match = {".* - VIM"                       }, tag = "6:code",     },
			{ match = { "zenity"			    }, intrusive = true, float = true},
			{ match = {"newsbeuter:.*"                  }, tag = "7:newsbeuter",},
			{ match = {"::ncmpcpp.*",                   }, tag = "5:ncmpcpp",  },
			{ match = {"MPlayer.*",                     }, tag = ":video", },
			{ match = {"MilkyTracker.*","Sound.racker.*"}, tag = ":TRACKZ", },
			{ match = {"Default - Wine desktop"         }, tag = ":Wine",         nopopup = true, },
			{ match = {"Deluge","rtorrent"              }, tag = ":p2p",                          },
			{ match = {"apvlv",                         }, tag = "8:PDF"},
			{ match = {"Xpdf.*",                        }, tag = "8:PDF"},
			{ match = {"gimp.toolbox",                 },  master = true , tag = ":gimp-tool" },
			{ match = {"gimp.dock",                 },  slave = true , tag = ":gimp-tool" },
			{ match = {"gimp-image-window",             }, master = true, tag = ":gimp" },
			{ match = {"feh.*"                          }, tag = ":img",                       },
			{ match = {"skype.*"                          }, tag = "9:skype",                       },
			{ match = { "mc -.+"                       }, tag = ":fs:",                           },
			{ match = { "" }, honorsizehints= true,
					 buttons = {
						 button({ }, 1, function (c) client.focus = c; c:raise() end),
						 button({ modkey }, 1, function (c) awful.mouse.client.move() end),
						 button({ modkey }, 3, awful.mouse.client.resize ), }, },

			   }



		-- }}}

		-- {{{ Wibox
		-- Create a textclock widget
		mytextclock = awful.widget.textclock({ layout = awful.widget.layout.horizontal.leftright}, "%y.%m.%d.%H.%M %W | ", 30 )

		-- Create a systray
		mysystray = widget({ type = "systray" })
		-- Create a wibox for each screen and add it
		mywibox = {}
		mybwibox = {}
		mypromptbox = {}
		mylayoutbox = {}
		mpdbox = {}
		infobox = {}
		mytaglist = {}
		mytaglist.buttons = awful.util.table.join(
					awful.button({ }, 1, awful.tag.viewonly),
					awful.button({ modkey }, 1, awful.client.movetotag),
					awful.button({ }, 3, awful.tag.viewtoggle),
					awful.button({ modkey }, 3, awful.client.toggletag),
					awful.button({ }, 4, awful.tag.viewnext),
					awful.button({ }, 5, awful.tag.viewprev)
					)
		mytasklist = {}
		mytasklist.buttons = awful.util.table.join(
					 awful.button({ }, 1, function (c)
								  if not c:isvisible() then
								  awful.tag.viewonly(c:tags()[1])
								  end
								  client.focus = c
								  c:raise()
							  end),
					 awful.button({ }, 3, function ()
								  if instance then
								  instance:hide()
								  instance = nil
								  else
								  instance = awful.menu.clients({ width=250 })
								  end
							  end),
					 awful.button({ }, 4, function ()
								  awful.client.focus.byidx(1)
								  if client.focus then client.focus:raise() end
							  end),
					 awful.button({ }, 5, function ()
								  awful.client.focus.byidx(-1)
								  if client.focus then client.focus:raise() end
							  end))

		for s = 1, screen.count() do
			-- Create a promptbox for each screen
			mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
			-- Create an mpd box for each screen
			mpdbox = widget({ screen = 1, type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			-- The infobox
			infobox = widget({ screen = 1, type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			-- Create an imagebox widget which will contains an icon indicating which layout we're using.
			-- We need one layoutbox per screen.
			mylayoutbox[s] = awful.widget.layoutbox(s, { layout = awful.widget.layout.horizontal.leftright })
			mylayoutbox[s]:buttons(awful.util.table.join(
					   awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
					   awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
					   awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
					   awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
			-- Create a taglist widget
			mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
			-- Create a tasklist widget
			mytasklist[s] = awful.widget.tasklist(function(c)
								  return awful.widget.tasklist.label.currenttags(c, s)
							  end, mytasklist.buttons)

			-- Create the wibox
			mywibox[s] = awful.wibox({ position = "top", screen = s, height = 37 })
			-- Add widgets to the wibox - order matters
			mywibox[s].widgets = {
			{
				{
			    	mylayoutbox[s],
			    	mytaglist[s],
			    	layout = awful.widget.layout.horizontal.leftright
				},
				infobox,
				mytextclock,
				mypromptbox[s],
				mpdbox,
				s == 1 and mysystray or nil,
				layout = awful.widget.layout.horizontal.rightleft
			},
			{
			mytasklist[s],
			layout = awful.widget.layout.horizontal.leftright
			},
			layout = awful.widget.layout.vertical.flex
			}

		end
		-- }}}

--{{{ Functions

--{{{ Get mpd info
function get_mpd()
  local stats = mpc:send("status")
   if stats.errormsg then
    mpd_text = "MPD not running? | "
   else
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
   mpd_text = now_playing .. " | "
 end
return mpd_text
end
--}}}

--{{{ get and display the album image in mpd
	function album_art()
		local stats = mpc:send("status")
		local zstats = mpc:send("playlistid " .. stats.songid)
		art = musicdir .. string.match(zstats.file, ".*/") .. "cover.jpg"
		return art
	end
--}}}

--{{{ Get playlist
function get_playlist ()
	local stats = mpc:send("status")
	local cur = stats.song
  local list = ""
	for i = stats.song-7,stats.song+6
		do
		zstats = mpc:send("playlistinfo " .. i)
		if zstats.pos == stats.song then
			list = list .. "<span color='#FF0000'> " .. zstats.pos .. ". " .. awful.util.escape((zstats.artist or "NA") .. " - " .. (zstats.title or zstats.file)) .. "</span>\n"
		else
			list = list .. " " .. zstats.pos .. ". " .. awful.util.escape(zstats.artist .. " - " .. (zstats.title or zstats.file) ) .. "\n"
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
function get_load_temp(sensor)
	local lf = io.open("/proc/loadavg")
	local tf = io.open("/proc/acpi/thermal_zone/" .. sensor .. "/temperature")
	
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
  file = io.open(pastefile, "a")
  file:write(bufcon)
  file:close()
  infobox.text = "wrote X buffer content to " .. pastefile
end
--}}}

--{{{ Open stuff with uzbl
function uzbl_prompt(prompt, text, socket, command)
      if command then
        -- if a command prefix is provided
        command = command .. ' '
      end
  --  awful.prompt.run({prompt=prompt, text=text},
   --     mypromptbox[mouse.screen],
   --     function(input)
  -- send through unix socket
    c = assert(socket.unix())
    assert(c:connect("/tmp/" .. socket))
    --while 1 do
     --   local l = io.read()
        assert(c:send("uri google.com\n"))
    -- end
   --end)
end
--}}}
--}}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
todomenu = {
   {"add", terminal },
   {"remove", terminal }
}
mymainmenu = awful.menu({ items = { 
                                    { "todomenu", todomenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key binding
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Tab",   awful.tag.viewprev       ),
    awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey            }, "n",           function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Control" }, "n",           function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey,           }, "c",           shifty.rename),
    awful.key({ modkey, "Control" }, "x",           shifty.delete),
    awful.key({ modkey, "Shift"   }, "o",      function() shifty.set(awful.tag.selected(mouse.screen), { screen = awful.util.cycle(screen.count() , mouse.screen + 1) }) end),

    --awful.key({ modkey,           }, "y", function () awful.layout.set(awful.layout.suit.fair) end),
   --awful.key({ modkey, "Shift"   }, "y", function () awful.layout.set(awful.layout.suit.max) end),
    awful.key({ modkey,           }, "y", function () awful.layout.inc(wwwlayouts,  1) end),
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
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "Scroll_Lock", function () awful.util.spawn(locker) end),
    awful.key({ modkey,           }, "F12", awesome.quit),
    awful.key({ modkey,           }, "F11", awesome.restart),
    -- devtodo
    awful.key({ modkey,           }, "t", function() show_todo() end),
    -- Start a new vim window
	--awful.key({modkey,  "Mod1"    }, "e", function () awful.util.spawn(terminal .. " -title '- VIM' -e " .. editor) end),
    -- MPD related
    awful.key({ modkey,           }, "p", function () naughty.notify{ icon = album_art(), icon_size= 128, text = get_playlist() } end),
    awful.key({ modkey, "Mod1"    }, "p", function () naughty.notify{ icon = "/home/dunz0r/gfx/def-cover.png", icon_size = 32 , text = get_playlist() } end),
    awful.key({ modkey, "Shift"   }, ",", function () mpc:previous() ; mpdbox.text = get_mpd() end),
    awful.key({ modkey,           }, "9", function () mpc:toggle_play() ; mpdbox.text = get_mpd() end),
    awful.key({ modkey,           }, "8", function () mpc:stop() ; mpdbox.text = get_mpd() end),
    awful.key({ modkey,           }, "7", function () mpc:toggle_random() ; infobox.text = "toggled random" end),
    awful.key({ modkey, "Shift"   }, ".", function () mpc:next() ; mpdbox.text= get_mpd() end),

    awful.key({ modkey, "Control" }, "p", function ()
      awful.prompt.run({ prompt = "Paste to: "},
      mypromptbox[mouse.screen].widget,
      function (s) paste(s) end,
	      awful.completion.shell) 
	end),
    awful.key({ modkey, "Shift"    }, "p", function () paste() end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Switch between awful.layout.suit.max and awful.layout.suit.fair if we are on tag 2:www
    -- else do nothing.
    --awful.key({ modkey,           }, "y",   function () if awful.layout.getname == awful.layout.suit.max then awful.layout.set(awful.layout.suit.fair) end end),
    --awful.key({ modkey,           }, "`",   naugthy.notify{ text = awful.tag.getproperty(awful.tag, name) }),
    -- Prompt
    awful.key({ modkey            }, "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey            }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "g",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind keys 1234,qwe,asd to tags 1 to 9
keys = {}
keys[1] = "1"
keys[2] = "2"
keys[3] = "3"
keys[4] = "q"
keys[5] = "w"
keys[6] = "e"
keys[7] = "a"
keys[8] = "s"
keys[9] = "d"
-- Compute the maximum number of digit we need, limited to 9
for i = 1, 12 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, keys[i],
            function () awful.tag.viewonly(shifty.getpos(i)) end),
        awful.key({ modkey, "Control" }, keys[i],
            function ()t = shifty.getpos(i); t.selected = not t.selected end),
        awful.key({ modkey, "Shift" }, keys[i],
            function ()
                if client.focus then 
                    local c = client.focus
                    slave = not ( client.focus == awful.client.getmaster(mouse.screen))
                    t = shifty.getpos(i)
                    awful.client.movetotag(t)
                    awful.tag.viewonly(t)
                    if slave then awful.client.setslave(c) end
                end 
            end
        )
    )
end


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}

shifty.taglist = mytaglist
shifty.init()
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Unreal Tournament 2004" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

boxtimer = timer { timeout = 5 }
boxtimer:add_signal("timeout", function() 
	infobox.text = get_load_temp("THRM")
	mpdbox.text = get_mpd() 
	end)
boxtimer:start()
mpdbox.text = get_mpd()

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
