
--############
-- All the fancy functions
--

-- Execute a command and return its output
function execute_command(command)
	local fh = io.popen(command)
	local sthr = ""
	for i in fh:lines() do
		sthr = sthr .. i
	end
	io.close(fh)
	return sthr
end
--
-- get battery info
 function batteryinfo(adapter)
     local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")   
     local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
     local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur * 100 / cap)
     if sta:match("Charging") then
         dir = "+"
         battery = "A/C " .. battery
     elseif sta:match("Discharging") then
         dir = "-"
         if tonumber(battery) < 10 then
                 naughty.notify({ title      = "Battery Warning"
                                , text       = "<big>Battery low!" .. battery .. "%" .. spacer .. "left!</big>"
                                , timeout    = 5
                                , position   = "top_right"
                                })
         end
     else
         dir = "="
         battery = "A/C"
     end
     battext = "| ".. dir .. " " .. battery
     fcur:close()
     fcap:close()
     fsta:close()
     return battext
 end
--

-- get mpd info
function get_mpd()
  function _timeformat(t)
	  if tonumber(t) >= 3600 then -- longer than an hour
		  return os.date("%X", t)
	  else
		  return os.date("%M:%S", t)
	  end
  end
  local now_playing, status 
  local stats = mpd.send("status")
  if stats.state == "stop" then
	 now_playing = " stopped" 
  else 
  	current_time = stats.time:match("(%d+):")
	total_time = stats.time:match("%d+:(%d+)")
	perctime = current_time / total_time * 100
	local zstats = mpd.send("playlistid " .. stats.songid)
	now_playing = "<b>np</b>:" .. "<i>" .. ( zstats.album  or "NA" ) .. ",</i> " .. ( zstats.artist or "NA" ) .. " - " .. (zstats.title or zstats.file) 
        now_playing = string.gsub(now_playing, "\&", "\&amp;")
	 if stats.state == "pause" then
	   now_playing = " <span color='#404040'>" .. now_playing .. "</span>"
  	 end
	end
  return now_playing  

end
--

-- get loadaverage and temperature
function load_temp()
	local lf = io.open("/proc/loadavg")
	tf = io.open("/proc/acpi/thermal_zone/THM0/temperature")
	
	l = lf:read()
	t = tf:read()

	l = string.match(l, "%d%.%d%d")
	t = string.match(t, "%d%d C")
	lf:close()
	tf:close()

	return " | " .. l .. " | " .. t
end
-- playlist
function show_playlist()
	local playlist = string.gsub(awful.util.pread("~/bin/playing"), "\&", "\&amp;")
	tplaylist = string.gsub(playlist, ">", "<span color='#FF0000'><big><b>></b></big></span>")
	local stats = mpd.send("status")
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
		title = "MPD:" .. status ,
		icon = os.getenv("HOME") .. "/.icons/mpd.png",
		icon_size = 32,
		timeout = 7,
		width = 400
	})
	end
-- Todo Manager 
   local todo = nil
   local offset = 0

    function show_todo(inc_offset)
        local save_offset = offset
        offset = save_offset + inc_offset
        local datespec = os.date("*t")
        datespec = datespec.year * 12 + datespec.month - 1 + offset
        datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
        local todo = awful.util.pread("todo --mono")
        todo = naughty.notify({
            text = string.format(os.date("%a, %d %B %Y") .. "\n" .. todo),
            timeout = 7, 
            width = 300,
        })
    end
    ---######
