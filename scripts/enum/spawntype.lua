-----------------------------------
-- Different Spawn Conditions
-----------------------------------
xi = xi or {}

xi.spawnType =
{
    SPAWNTYPE_NORMAL    = 0x00, -- 00:00-24:00
    SPAWNTYPE_ATNIGHT   = 0x01, -- 20:00-04:00
    SPAWNTYPE_ATEVENING = 0x02, -- 18:00-06:00
    SPAWNTYPE_ATDUSK    = 0x03, -- 17:00-07:00
    SPAWNTYPE_WEATHER   = 0x04,
    SPAWNTYPE_FOG       = 0x08, -- 02:00-07:00
    SPAWNTYPE_MOONPHASE = 0x10,
    SPAWNTYPE_LOTTERY   = 0x20,
    SPAWNTYPE_WINDOWED  = 0x40,
    SPAWNTYPE_SCRIPTED  = 0x80, -- scripted spawn
}
