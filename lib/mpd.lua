-- Small interface to MusicPD
-- use luasocket, with a persistant connection to the MPD server.
--
-- Author: Alexandre "kAworu" Perrin &lt;kaworu at kaworu dot ch&gt;
--
-- based on a netcat version from Steve Jothen <sjothen at gmail dot com>
-- (see "http://github.com/otkrove/ion3-config/tree/master/mpd.lua" 
require("socket")

-- Grab env
local socket = socket
local string = string
local tonumber = tonumber

-- Music Player Daemon Lua library.
module("mpd")
local settings =
{
  hostname = "localhost",
  port = 6600
}

-- our socket
local sock = nil;

-- override default settings values
function setup(hostname, port, password)
  settings.hostname = hostname
  settings.port = port
  settings.password = password
end


-- calls the action and returns the server's response.
--      Example: if the server's response to "status" action is:
--              volume: 20
--              repeat: 0
--              random: 0
--              playlist: 599
--              ...
--      then the returned table is:
--      { volume = 20, repeat = 0, random = 0, playlist = 599, ... }
function send(action)
  local command = string.format("%s\n", action)
  local values = {}

  -- connect to MPD server if not already done.
  if not sock then
    sock = socket.connect(settings.hostname, settings.port)
    if sock and settings.password then
      send(string.format("password %s", settings.password))
    end
  end

  if sock then
    sock:send(command)
    local line = sock:receive("*l")

    if not line then -- closed (mpd killed?): reset socket and retry
      sock = nil
      send(action)
    end

    while not line:match("^OK$") or line:match(string.format("unknown command \"%s\"", action)) do
      local _, _, key, value = string.find(line, "(.-):%s(.+)")
      if key then
        values[string.lower(key)] = value
      end
      line = sock:receive("*l")
    end
  end

  return values
end

function next()
  send("next")
end

function previous()
  send("previous")
end

function pause()
  send("pause")
end

function stop()
  send("stop")
end

-- no need to check the new value, mpd will set the volume in [0,100]
function volume_up(delta)
  local stats = send("status")
  local new_volume = tonumber(stats.volume) + delta
  send(string.format("setvol %d", new_volume))
end

function volume_down(delta)
  volume_up(-delta)
end

function toggle_random()
  local stats = send("status")
  if tonumber(stats.random) == 0 then
    send("random 1")
  else
    send("random 0")
  end
end

function toggle_repeat()
  local stats = send("status")
  if tonumber(stats["repeat"]) == 0 then
    send("repeat 1")
  else
    send("repeat 0")
  end
end

function toggle_play()
  if send("status").state == "stop" then
    send("play")
  else
    send("pause")
  end
end

