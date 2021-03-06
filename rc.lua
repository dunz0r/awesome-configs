	-- Standard awesome library
	require("awful")
	require("awful.autofocus")
	require("awful.rules")
	-- Theme handling library
	require("beautiful")
	-- Notification library
	require("naughty")
	-- Dynamic Tagging
	require("shifty")
	-- kAwouru's MPD library
	require("lib/mpd") ; mpc = mpd.new({ hostname="localhost"  })
	-- Keybind libraray by ierton
	require("lib/keybind")
	-- Cool stuff
	require("lib/revelation")
	-- Widgets
	require("vicious")
	-- {{{ Variable definitions
	-- Themes define colours, icons, and wallpapers
	theme_path = os.getenv("HOME") .. "/.config/awesome/theme.lua"
	beautiful.init(theme_path)
	
	-- This is used later as the default terminal and editor to run.
	terminal = "urxvtc"
	editor = os.getenv("EDITOR") or "vim"
	editor_cmd = terminal .. " -e " .. editor
	locker = "vlock -n"
	browser = "luakit"
	musicdir = "/home/dunz0r/warez/music/"
	weatherurl = "http://www.accuweather.com/m/en-us/EUR/SE/SW015/Upplands-Vasby/Forecast.aspx"
	-- where to paste
	pastebin = os.getenv("HOME") .. "/.pastebin"
	-- menu bindings
	awful.menu.menu_keys.up = { "k"}
	awful.menu.menu_keys.down = { "j"}
	awful.menu.menu_keys.exec = { "g"}
	-- what to use as a separator
	sep = " <span weight='bold' font='Fixed' color='" .. beautiful.fg_focus .. "'>|</span> "
	modkey = "Mod4"

	-- Table of layouts to cover with awful.layout.inc, order matters.
	layouts =
	{
		awful.layout.suit.tile,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
		awful.layout.suit.fair,
		awful.layout.suit.fair.horizontal,
		awful.layout.suit.max,
		awful.layout.suit.max.fullscreen,
		awful.layout.suit.magnifier,
		awful.layout.suit.floating
	}
	-- Table of layouts to use on the www tag
	wwwlayouts = 
	{
		awful.layout.suit.max,
		awful.layout.suit.fair
	}
	-- }}}

		-- {{{ Shifty
		-- {{{ Config defaults
		shifty.config.defaults = {
		layout = awful.layout.suit.tile,
		floatBars = true,
		run = function(tag)
		naughty.notify({ text = "Shifty Created "..
				 (awful.tag.getproperty(tag,"position") or shifty.tag2index(mouse.screen,tag)).." : "..
				 (tag.name or "foo")
				})
		end,
		guess_name = true,
		persist = false,
		leave_kills = false,
		exclusive = true,
		guess_position = true,
		remember_index = true,
		ncol = 1,
		floatBars=true,
		mwfact = 0.5,
		nopopup = true
		}
		--}}}
		
		-- {{{ Tags
		shifty.config.tags = {
                irc = { name = "1:irc", spawn = terminal .. " -name SSH -title '::irssi::' -e ssh -t dunz0r@hax0r.se tmux attach ", position = 1, },
		www = { solitary = true, position = 2, max_clients = 5,
				exclusive = false, layout = awful.layout.suit.max, nopopup = true, spawn = browser},
		term = { persist = true, position = 3, },
		ncmpcpp = { nopopup = true, persist = false, position = 5,
				spawn = terminal .. " -name '::ncmpcpp::' -title '::ncmpcpp::' -e ncmpcpp", },
		code = { spawn = terminal .. " -title '- VIM' -e sh -c 'sleep 0.2s;" .. editor .. "'", nopopup = false, position = 6,
				layout = awful.layout.suit.max },
		mutt = { position = 7, layout = awful.layout.suit.max, 
				spawn = terminal .. " -name mutt -title '::mutt::' -e sh -c 'sleep 0.1s;mutt'", nopopup = false, },
		news = { position = 10, spawn = terminal .. " -name Newsbeuter -title '::newsbeuter::' -e newsbeuter" },
		video = { nopopup = false, position = 4, layout = awful.layout.suit.float, },
		PDF = { layout = awful.layout.suit.max.fullscreen, position = 8, nopopup = false },
		img = { position = 9, layout = awful.layout.suit.max.fullscreen, nopopup = false, },
		-- No fixed positions
		gimp = { spawn = "gimp", layout = awful.layout.suit.max, sweep_delay = 2, screen = 1,  },
		gimptool = { layout = awful.layout.suit.tile, sweep_delay = 2, screen = 2,  },
		wine = { layout = awful.layout.suit.float }
		}
		--}}}
		
		-- {{{ Apps
		shifty.config.apps = {
			{ match = { "::irssi::",                    }, tag = "irc", },
			{ match = { "SSH",                    }, tag = "irc", },
			{ match = { "::mutt::",                    }, tag = "mutt", },
			{ match = {"::luakit::"       }, nopopup = true, tag = "www" },
			{ match = {"luakit"       }, nopopup = true, tag = "www" },
			{ match = {"uzbl"       }, nopopup = true, tag = "www" },
			{ match = {"urxvt"                          }, tag = "term",     },
			{ match = {"xev"                            }, intrusive = true,     },
			{ match = {"::term::"                        }, tag = "term",     },
			{ match = {"::newsbeuter::"                        }, tag = "news",     },
			{ match = {".* - VIM"                       }, tag = "code",     },
			{ match = { "zenity"                        }, intrusive = true, float = true},
			{ match = {"::ncmpcpp.*",                   }, tag = "ncmpcpp",  },
			{ match = {"MPlayer",                     }, tag = "video", },
			{ match = {"MilkyTracker.*","Sound.racker.*"}, tag = "TRACKZ", },
			{ match = {"wine"                           }, tag = "wine"},
			{ match = {"apvlv", "Xpdf", "zathura"       }, tag = "PDF"},
			{ match   = {"gimp%-dock", "gimp%-toolbox"},
					tag     = "gimptool",
					slave   = true, float = false, dockable = true, honorsizehints=false },
			{ match = {"gimp%-image-window",             }, master = true, tag = "gimp" },
			{ match = {"feh.*"                          }, tag = "img",          },
			{ match = {"skype.*"                        }, tag = "skype",       },
			{ match = {".*Sun Virtualbox"               }, tag = "Vbox",        },
			{ match = {""},
    				buttons = awful.util.table.join(
        				awful.button({}, 1, function(c) client.focus = c; c:raise() end),
        				awful.button({modkey}, 1, function(c)
            				client.focus = c
            				c:raise()
            				awful.mouse.client.move(c)
        				end),
        				awful.button({modkey}, 3, awful.mouse.client.resize))
  					}
			}
			-- }}}
		-- }}}

--{{{ Vicious
-- CPU Widget
-- Initialize widget
cpuwidget = awful.widget.graph()
-- Graph properties
cpuwidget:set_width(80)
cpuwidget:set_height(12)
cpuwidget:set_background_color(beautiful.bg_normal)
cpuwidget:set_border_color(beautiful.fg_focus)
cpuwidget:set_color(beautiful.fg_focus)
-- Register widget
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

-- CPU Usage textbox
-- Initialize widget
cputext = widget({ type = "textbox" })
cputext.width = 83 
-- Register widget
vicious.register(cputext, vicious.widgets.cpu, " <span color='" .. beautiful.wid_rh .. "'>CPU: $1%</span>" .. sep)

-- Memory usage graph
-- Initialize widget
memwidget = awful.widget.progressbar()
-- Progressbar properties
memwidget:set_width(50)
memwidget:set_height(12)
memwidget:set_background_color(beautiful.bg_normal)
memwidget:set_border_color(beautiful.fg_focus)
memwidget:set_color(beautiful.fg_focus)
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)

-- Memory usage box
-- Initialize widget
memtext = widget({ type = "textbox" })
-- Register widget
vicious.register(memtext, vicious.widgets.mem, "<span color='" .. beautiful.wid_ch  .."'> MEM:</span> $1% ($2MB/$3MB)" .. sep, 13)

-- Netwidgets
-- Initialize widget
nettext = widget({ type = "textbox" })
-- Register widget
vicious.register(nettext, vicious.widgets.net, "<span color='" .. beautiful.wid_bh .. "'>ETH0</span> TX:${eth0 down_kb} RX:${eth0 up_kb}" .. sep, 13)


--}}}

		-- {{{ Wibox
		-- Create a textclock widget
		mytextclock = awful.widget.textclock({ layout = awful.widget.layout.horizontal.leftright}, "%y.%m.%d.%H.%M:%W" .. sep, 20 )
		-- Create a systray
		mysystray = widget({ type = "systray" })
		-- Create a wibox for each screen and add it
		mywibox = {}
		myawibox = {}
		mybwibox = {}
		promptbox = {}
		pacmanbox = {}
		mylayoutbox = {}
		mpdbox = {}
		mcbox = {}
		infobox = {}
		separator = {}
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
								  instance = awful.menu.clients({ width=250 }, true)
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
			promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
			-- Create an mpd box
			mpdbox = widget({ screen = 1, type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			pacmanbox = widget({ type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			mcbox[s] = widget({ screen = s, type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			-- The infobox
			infobox = widget({ screen = s, type = "textbox", layout = awful.widget.layout.horizontal.leftright })
			-- a separator
			separator = widget({ type = "textbox", })
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
			mywibox[s] = awful.wibox({ position = "top", screen = s })
			-- Add widgets to the wibox - order matters
			mywibox[s].widgets = {
				        mylayoutbox[s],
					mytaglist[s],
					promptbox[s],
					mcbox[s],
					s == 1 and mysystray or nil,
				        mytasklist[s],
				        layout = awful.widget.layout.horizontal.leftright
			}

		end

		mybwibox = awful.wibox({ position = "bottom", screen = 1})

		mybwibox.widgets = {

                        		mytextclock,
					mpdbox,
					cpuwidget.widget,
					cputext,
					memwidget.widget,
					memtext,
					infobox,
					nettext,
					layout = awful.widget.layout.horizontal.leftright

		                   }

	--[[	myawibox = awful.wibox({ position = "bottom", screen = 1})
		myawibox.widgets = {
                        		mytextclock,
                        		pacmanbox,
					layout = awful.widget.layout.horizontal.leftright
                }
                --]]
-- }}}

--{{{ Functions

--{{{ Get the Xdefault colours
function get_xdef(file)
	local fr = io.open(file)
	
	local f = fr:read("*all")

    local i=0
    while i <= 15 do
	local exp = tostring("%*color" .. i .. ": rgb:%w+/%w+/%w%w")
	m = string.match(f, exp)
	
	m = string.gsub(m, "^.*:","")
	m = string.gsub(m, "/","")
	xdef_col = {}
	xdef_col[i] = "#" .. m
	--xdef_col[i] = "theme.xdef_col" .. i .. "=\"#" .. (tostring(m)) .. "\""
	i= i + 1
	--xdef_col[i] = tostring(xdef_col[i])
	--print(xdef_col[i])
	xdef_col[i] = tostring(m)
	print(xdef_col[i])
    end
    fr:close()
    return xdef_col{}
end

--}}}

--{{{ Get MPD info
function get_mpd()
        local stats = mpc:send("status")

        if stats.errormsg then
            mpd_text = "MPD error."
        else
            if stats.state == "stop" then
                now_playing = awful.util.escape("<stop>")
            else
                local zstats = mpc:send("playlistid " .. stats.songid)
  	            now_playing =  "#" .. zstats.pos .. " " .. (awful.util.escape( zstats.album  or "NA" )) .. "<b>:</b> " .. (awful.util.escape( zstats.artist or "NA" )) .. " <b>-</b> " .. (awful.util.escape(zstats.title or string.gsub(zstats.file, ".*/", "" ) ))
            end

            if stats.state == "pause" or stats.state == "stop" then
                now_playing = "<span color='".. beautiful.fg_unfocus .."'>" .. now_playing .. "</span>"
            end

            mpd_text = " <span color='" .. beautiful.wid_ml .. "'>np: </span><span color='" .. beautiful.wid_gh .. "'>" .. now_playing .. "</span>"
        end

        return mpd_text
    end
--}}}

--{{{ Get the album image
	function album_art()
		local stats = mpc:send("status")
		local zstats = mpc:send("playlistid " .. stats.songid)
		art = awful.util.pread('find "' .. musicdir .. awful.util.unescape(string.match(zstats.file, ".*/")) .. '" -regextype posix-egrep -iregex ".*(cover|front|albumart|outside|folder).*(png|jpg|gif|bmp)" | head -1')

		return string.gsub(art,"\n","")
	end
--}}}

--{{{ Get playlist
function get_playlist ()
	local stats = mpc:send("status")
	local cur = stats.song
	local list = ""
	if tonumber(stats.song) < 10 then
		min = tonumber(stats.song)
	else
		min = 10
	end
	for i = stats.song - min,stats.song + 6
		do
		zstats = mpc:send("playlistinfo " .. i)
		if zstats.pos == nil then
			list = list .. "<span color=" .. beautiful.wid_rh .. "><b>::end::</b></span>"
			break
		end
		if zstats.pos == stats.song then
			list = list .. "<span color='" .. beautiful.wid_bh .. "'><b>" .. zstats.pos .. ". " .. awful.util.escape((zstats.artist or "NA") .. " - " .. (zstats.title or zstats.file)) .. "</b></span>\n"
		else
			list = list .. zstats.pos .. ". " .. awful.util.escape((zstats.artist or "NA") .. " - " .. (zstats.title or zstats.file) ) .. "\n"
		end
	end
    return list
end
--}}}

--{{{ Find song in playlist and play it.
 function grep(c,q,l)
        s = ""
        x = 0 
        f = assert(io.popen(c .." " ..  q, 'r'))
        if not l then
            l = 30
        end 

        for line in f:lines() do
            if x > l then
                s = s .. "\n\nMore than "..l.." results"
                break
            end 

            s = s .. "\n" .. string.gsub(awful.util.escape(line),"^%d-%)","<span color='"..beautiful.fg_unfocus.."'>%0</span>")
            x = x + 1 
        end 

        if x == 1 then
            os.execute("mpc play " .. string.gsub(string.gsub(s,"%).*",""),".*>","") .. " &> /dev/null")
            mpdbox.text = get_mpd()

            return "One match autostart.\n" .. get_mpd()
        elseif x ~= 0 then
            s = string.gsub(s,nocase(q),"<span color='"..beautiful.fg_highlight.."'>%0</span>")
            return s
        else
            return "No matches"
        end 
    end 

--}}}

--{{{ Add a todo note

	function add_todo (todo)
		naughty.notify({
		text = "<b><u>devtodo: </u></b> " .. "<span color='" .. beautiful.fg_focus .. "'>" .. awful.util.pread("todo --add --priority " .. todo) .. "</span>",
		timeout = 10
		})
	end
--}}}

--{{{ Show todos
    function show_todo(graft)
        local todo = awful.util.escape(awful.util.pread("todo --mono"))
        todo = naughty.notify({
            text = "<b><u>devtodo</u></b>\n" .. "<span color='" .. beautiful.wid_cl .. "'>".. string.format(os.date("%a, %d %B %Y") .. "</span>" .. "\n" .. todo),
            timeout = 10
        })
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

--{{{ Get loadaverage and temperature
function get_load_temp(sensor)
	local lf = io.open("/proc/loadavg")
	local tf = io.open("/proc/acpi/thermal_zone/" .. sensor .. "/temperature")
	
	local l = lf:read()
	local t = tf:read()

	local t = string.match(t, "%d+ C")
	lf:close()
	tf:close()

	return "<span color='" .. beautiful.wid_mh .. "'>" .. l .. "</span>".. sep .. "<span color='".. beautiful.wid_ml .. "'>" .. t .. "</span>" .. sep
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

--{{{ Get the weather
	function get_weather(ret)
	
	if ret == 1 then	
		local fp = io.open("/tmp/.weather")
		local forecast = fp:read("*a")
		fp:close()
		return "<span color='" .. beautiful.wid_rh .. "'>weather for upplands v�sby</span>\n"  .. forecast
	else
		os.execute("wget -q -O - " .. weatherurl .. " | sed -n '/Now/,/More Forecasts/p' | sed 's/<[^>]*>//g; s/^ [ ]*//g; s/&copy;/(c) /g; s/&amp;/and/;s/&deg;//g;s/&nbsp;//g;s/Details//g;s/|//g;s/Hourly//g;s/More Forecasts//'|uniq -u > /tmp/.weather &")
		return ""
	end
	end
--}}}

--{{{ Paste to (pastefile) or pastebin
function paste (pastefile)
  local bufcon = selection()
  local pastefile = pastefile or pastebin
  local file = io.open(pastefile, "a")
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
   --     promptbox[mouse.screen],
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

--{{{ Finds string in command
	function commandfind (command, string)
		local cmd = awful.util.pread(command)
		local result = string.match(cmd,string)
		return result
	end
--}}}

--{{{ Find client
function clientfind (properties)
   local clients = client.get()
   local rv = nil
   for i, c in pairs(clients) do
      if match(properties, c) then
        rv = c
      end
   end
   return rv
end

--}}}

--{{{ Get ncol and nmaster
function getnmc()
    local t = awful.tag.selected()

    local m = awful.tag.getnmaster(t)
    local c = awful.tag.getncol()

    return m .. "m " .. c "c"
end
--}}}

--{{{ Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v then
         return false
      end
   end
   return true
end
--}}}

--{{{ Get pacman updates
function get_pmupdates()
    local p = awful.util.pread("pacman -Qu|wc -l")
    return "<span color='" .. beautiful.wid_yh .. "'>pacman: </span>" .. p
end
--}}}

--}}}

--{{{ Bindings
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key binding
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Tab",  awful.tag.viewprev       ),
    awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewnext       ),
    awful.key({ modkey, "Control" }, "n",    shifty.add),
    awful.key({ modkey,           }, "n",    shifty.send_next),
    awful.key({ modkey, "Shift"   }, "r",    shifty.rename),
    awful.key({ modkey, "Shift"   }, ".",    shifty.del),
    awful.key({ modkey,           }, "o",    function() shifty.set(awful.tag.selected(mouse.screen), { screen = awful.util.cycle(screen.count() , mouse.screen + 1) }) end),

-- {{{ Modal bindings
	--{{{ devtodo, modal bindings
	awful.key({ modkey,           }, "t", function () 
		keybind.push({
			keybind.key({}, "Escape", "cancel", function ()
			keybind.pop()
		end),
		keybind.key({}, "d", "show todos", function ()
			show_todo()
			keybind.pop()
		end),
		keybind.key({}, "a", "add a todo", function ()
			awful.prompt.run(
			{ prompt = "add a todo: "},
			promptbox[mouse.screen].widget,
		function (t)
			add_todo(t)
		end,
		awful.completion.bash
		)
		keybind.pop()
		end),
		keybind.key({}, "r", "delete a todo", function ()
			awful.prompt.run(
			{ prompt = "delete todo: "},
			promptbox[mouse.screen].widget,
		function (t)
			naughty.notify({
				text = "<b><u>devtodo: </u></b> " .. "<span color='" .. beautiful.fg_focus .. "'>" .. "removed todo #" .. t .. "</span>",
				timeout = 6,
			})
			awful.util.spawn("tdr " .. t)
		end,
		awful.completion.bash
		)
		keybind.pop()
		end),

	}, "::devtodo::")
	end),
	--}}}

	--{{{ mpd, modal bindings
	awful.key({ modkey,         }, "m", function ()
		keybind.push({
			keybind.key({}, "Escape", "cancel", function ()
				keybind.pop()
			end),
			keybind.key({}, "p", "playlist", function ()
				naughty.notify{ position = "bottom_right", title = get_mpd(), icon = album_art(), icon_size= 128,
				text = get_playlist(), timeout = 8 }
				keybind.pop()
			end),
			keybind.key({}, "l", "next track" , function ()
				mpc:next() ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "h", "previous track" , function ()
				mpc:previous() ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "k", "volume up" , function ()
				mpc:volume_up(5) ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "j", "volume down" , function ()
				mpc:volume_down(5) ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "x", "toggle play" , function ()
				mpc:toggle_play() ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "s", "stop" , function ()
				mpc:stop() ; mpdbox.text = get_mpd()
				keybind.pop()
			end),
			keybind.key({}, "z", "toggle random" , function ()
				mpc:toggle_random()
				keybind.pop()
			end),
			keybind.key({}, "r", "toggle repeat" , function ()
				mpc:toggle_repeat()
				keybind.pop()
			end),

		}, "::mpd::")
	end),
	--}}}

	--{{{ Info, modal bindings
	awful.key({ modkey,         }, "i", function ()
		keybind.push({
			keybind.key({}, "Escape", "cancel", function ()
				keybind.pop()
			end),
			keybind.key({}, "w", "show weather", function ()
				naughty.notify{ position = "top_right", title = "::weather::",
				text = get_weather(1), timeout = 10 }
				keybind.pop()
			end),
			keybind.key({}, "c", "show tag info", function ()
				naughty.notify{ position = "top_right", title = "::tag::",
				text = getnmc(), timeout = 10 }
				keybind.pop()
			end),
			keybind.key({}, "d", "disk info", function ()
				naughty.notify{ position = "top_right", title = "::disks::",
				text = awful.util.pread("df -h|sed '/none.*$/d'"), timeout = 10 }
				keybind.pop()
			end),
			keybind.key({}, "p", "processes", function ()
				naughty.notify{ position = "top_right", title = "::processes::",
				text = awful.util.pread("ps ux"), timeout = 15 }
				keybind.pop()
			end),
			keybind.key({}, "a", "archey", function ()
				naughty.notify{ position = "top_right", title = "::processes::",
				text = awful.util.pread("archey"), timeout = 15 }
				keybind.pop()
			end),

		}, "::info::" )
	end),
	--}}}
-- }}}
    -- switch layouts on the 2:www tag
    awful.key({ modkey,           }, "y", function () awful.layout.inc(wwwlayouts,  1) end),
	-- focus switching
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
	-- this will bring up a menu of all clients and let you choose one
	awful.key({ modkey,           },"Escape", function () awful.menu.clients({ width=250 }, true) end),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,           }, "<", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Shift"   }, "<", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "b", revelation.revelation),
    
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "Scroll_Lock", function () awful.util.spawn(locker) end),
    awful.key({ modkey,           }, "F11", awesome.restart),
    awful.key({ modkey,           }, "F12", awesome.quit),

    awful.key({ modkey, "Control" }, "p", function ()
      awful.prompt.run({ prompt = "Paste to: "},
      promptbox[mouse.screen].widget,
      function (s) paste(s) end,
	      awful.completion.shell) 
	end),
    awful.key({ modkey,           }, "p", function () paste() end),

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
    awful.key({ modkey            }, "r",     function () promptbox[mouse.screen]:run() end),

    awful.key({ modkey, "Control" }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  promptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, ".",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "F12", awesome.quit),
    awful.key({ modkey,           }, "F12", awesome.quit),
    awful.key({ modkey,           }, "F12", awesome.quit),
    awful.key({ modkey,           }, "F12", awesome.quit),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind keys 123,qwe,asd,zxc to tags 1 to 12
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
keys[10] = "z"
keys[11] = "x"
keys[12] = "c"
-- Compute the maximum number of digit we need, limited to 9
for i=1,12 do
  
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, keys[i],
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, keys[i],
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Mod1" }, keys[i],
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, keys[i],
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
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
--}}}
shifty.taglist = mytaglist
shifty.init()
--{{{ Rules
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
    { rule = { class = "Uzbl" },
	  properties = { focus = false, lower = true } },
    { rule = { class = "Unreal Tournament 2004" },
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
weathertimer = timer { timeout = 600 }
weathertimer:add_signal("timeout", function()
		get_weather(0)
		pacmanbox.text = get_pmupdates()
	end)

client.add_signal("focus",  function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

tag.add_signal("property::ncol", function () mcbox[s].text = getnmc() end)
tag.add_signal("property::nmaster", function() mcbox[s].text = getnmc() end)
-- }}}
-- stuff to do so we don't have to wait for boxes and the likes to update
get_weather(0)
pacmanbox.text = get_pmupdates()
mpdbox.text = get_mpd()
infobox.text = get_load_temp("THRM")
get_xdef("/home/dunz0r/.Xdefaults")
separator.text = sep
awful.util.spawn("xset -b")
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80:foldmarker={{{,}}}
