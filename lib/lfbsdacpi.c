
 /*
 *  _ _____ ____ ____  ____                   _
 * | |  ___| __ ) ___||  _ \  __ _  ___ _ __ (_)
 * | | |_  |  _ \___ \| | | |/ _` |/ __| '_ \| |
 * | |  _| | |_) |__) | |_| | (_| | (__| |_) | |
 * |_|_|   |____/____/|____/ \__,_|\___| .__/|_|
 *                                     |_|
 * lua.FreeBSD.acpi:
 *   a small sysctl(3) interface for Lua.
 *
 * get ACPI infos (battery, temperature).
 *
 *-----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <kaworu(a)kaworu,ch> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 * ----------------------------------------------------------------------------
 */


#include <sys/types.h>
#include <sys/sysctl.h>

#include <stdlib.h>

/* Include the Lua API header files */
#include "lua51/lua.h"
#include "lua51/lauxlib.h"
#include "lua51/lualib.h"

/*
 * sysctl key's that we use
 */
#define BAT_LIFE "hw.acpi.battery.life"
#define BAT_TIME "hw.acpi.battery.time"
#define ACLINE   "hw.acpi.acline"
#define TEMP     "hw.acpi.thermal.tz0.temperature"

int
my_sysctl(const char *name)
{
    int data[1];
    int *mib, *omib;
    size_t miblen, datalen;
    const char *c;

    miblen = 1;
    for (c = name; *c != '\0'; c++) {
        if (*c == '.')
            miblen++;
    }

    datalen = sizeof(data);
    mib = omib = calloc(miblen, sizeof(int));

    if (mib == NULL)
        return (-2);

    sysctlnametomib(name, mib, &miblen);
    if (sysctl(mib, miblen, &data, &datalen, NULL, 0) == -1)
            return (-1);

    free(omib);
    return (data[0]);
}

static int
luaA_battery_life(lua_State *L)
{
    lua_pushnumber(L, my_sysctl(BAT_LIFE));
    return (1); /* one returned value */
}

static int
luaA_battery_time(lua_State *L)
{
    /* returned value is in mins. we return in sec */
    lua_pushnumber(L, my_sysctl(BAT_TIME) * 60);
    return (1); /* one returned value */
}

static int
luaA_acline(lua_State *L)
{
    lua_pushboolean(L, my_sysctl(ACLINE));
    return (1); /* one returned value */
}

static int
luaA_temperature(lua_State *L)
{
    /* returned value is in Kelvin * 10. we return in Celcius */
    lua_pushnumber(L, my_sysctl(TEMP) / 10 - 273);
    return (1); /* one returned value */
}

static const luaL_reg lfbsdacpi[] =
{
    {"life",        luaA_battery_life},
    {"time",        luaA_battery_time},
    {"acline",      luaA_acline},
    {"temperature", luaA_temperature},
    {NULL,          NULL}
};


/*
 * Open our library
 */
LUALIB_API int
luaopen_fbsdacpi(lua_State *L)
{
    luaL_openlib(L, "acpi", lfbsdacpi, 0);
    return (1);
}

/*to compile it: cc -shared -soname lfbsdacpi -fPIC -o lfbsdacpi.so -I /usr/local/include lfbsdacpi.c
[edit] creating the ACPI Widget
*/

