-- Functions for awesome
-- by Gabriel "dunz0r" Fornaeus
-- gfornaeus@gmail.com

-- get mpd info
--{{
function get_mpd()
  local stats = mpd.send("status")
  if stats.state == "stop" then
	 now_playing = " stopped"
  else
	  if stats.random == "1" then
		  rand = "(<span color='#FF0000'>R</span>)"
	  else
		  rand = ""
	  end
	local zstats = mpd.send("playlistid " .. stats.songid)
	now_playing = " <span color='#00FF00'><b>np:</b></span>" .. rand .. ( zstats.album  or "NA" ) .. "; " .. ( zstats.artist or "NA" ) .. " - " .. (zstats.title or zstats.file)
	 if stats.state == "pause" then
	   now_playing = " <span color='#606060'>" .. now_playing .. "</span>"
  	 end
	end
  now_playing = string.gsub(now_playing, "\&", "\&amp;")
  return now_playing .. " | "

end
--}}

-- shows playlist
--{{
function show_playlist()
	local stats = mpd.send("status")
	local tplaylist = string.gsub(awful.util.pread("~/bin/playing"), "\&", "\&amp;")
	tplaylist = string.gsub(tplaylist, ">", "<span color='#FF0000'>></span>")
	if stats.state == "stop" then
		status = "Stopped"
	else
		if stats == "pause" then
			status = "Paused"
		else
			status = "Playing"
		end
	end
	playlist = naughty.notify({ text = tplaylist,
		title = "MPD: " .. status ,
		icon = os.getenv("HOME") .. "/.icons/mpd.png",
		icon_size = 32,
		timeout = 7,
		width = 400
	})
	end
--}}

-- shows batteryinfo for (adapter)
--{{
 function batteryinfo(adapter)

     local fcur = io.open("/sys/class/power_supply/" .. adapter .. "/energy_now")
     local fcap = io.open("/sys/class/power_supply/" .. adapter .. "/energy_full")
     local fsta = io.open("/sys/class/power_supply/" .. adapter .. "/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur / cap * 100)
     if sta:match("Charging") then
         dir = "+"
     elseif sta:match("Discharging") then
         dir = "-"
     elseif sta:match("Full") then
         dir = "="
     end
     batterybox.text = " | " .. "<span color='#FFFF00'>" .. dir .. " </span>"
     batbar:bar_data_add("bat",tonumber(battery) )
     fcur:close()
     fcap:close()
     fsta:close()
 end
 --}}

-- get loadaverage and temperature
--{{
function load_temp()
	local lf = io.open("/proc/loadavg")
	local tf = io.open("/proc/acpi/thermal_zone/THM0/temperature")
	
	l = lf:read()
	t = tf:read()

	l = string.match(l, "%d+%.%d%d")
	t = string.match(t, "%d+ C")
	lf:close()
	tf:close()

	return "<span color='#FF00FF'>"  .. l .. "</span>" .. " | <span color='#FF0000'>" .. t .. "</span>"
end
--}}

-- Todo Manager
--{{
    function show_todo()
        local datespec = os.date("*t")
        datespec = datespec.year * 12 + datespec.month - 1
        datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
        local todo = awful.util.pread("todo --mono")
        todo = naughty.notify({
            text = string.format(os.date("%a, %d %B %Y") .. "\n" .. todo),
            timeout = 7,
	    bg = beautiful.bg_widget,
            width = 300,
        })
    end
--}}

