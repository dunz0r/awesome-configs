local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

local capi = {
	io = io,
	screen = screen,
	tag = tag,
	client = client,
	mouse = mouse,
	root = root,
	key = key,
}

local table = table
local awesome = awesome
local ipairs = ipairs
local pairs = pairs
local tostring = tostring

module("keybind")

local notify_keychain = nil

local newkeys = nil

function push_(mytable,ftitle, setter, getter)
	local description = ""
    for _, k in ipairs(mytable) do
		newkeys = awful.util.table.join(newkeys, k.keys)
		description = description .. "\n"
		description = description ..  tostring(k.keysym) .. ": " ..  ( k.desc or "<no_description>" )
    end

	local globalkeys = awful.util.table.join(
		getter(), newkeys)

	setter(globalkeys)

    if not notify_keychain then
        notify_keychain = naughty.notify({
            title = ftitle,
            text = description,
            timeout = 0,
            position = "bottom_right",
        })
    end
end

-- Will inser keys from mytable to the end of globalkeys
-- one has to call pop() with same mytable
function push(mytable,ftitle)
    return push_(mytable, ftitle, 
        function(val) capi.root.keys(val) end,
        function() return capi.root.keys() end)
end

function push_client(mytable,ftitle, c)
    return push_(mytable, ftitle, 
        function(val) c:keys(val) end,
        function() return c:keys() end)
end

-- removes previously set items from the end of keys
function pop_(setter, getter)

	local globalkeys = getter()
    for k, v in ipairs(newkeys) do
        table.remove(globalkeys)
    end

	setter(globalkeys)
    newkeys = nil

    if notify_keychain then
        naughty.destroy(notify_keychain)
        notify_keychain = nil
    end
end

function pop()
    return pop_(
        function(val) capi.root.keys(val) end,
        function() return capi.root.keys() end)
end

function pop_client(c)
    return pop_(
        function(val) c:keys(val) end,
        function() return c:keys() end)
end

function key(mod, key, desc, press)
	local k = {
		keys = awful.key(mod, key, press),
		desc = tostring(desc),
		keysym = tostring(key),
	}
	return k
end

