-----------------------------------
-- SpawnType
-----------------------------------
xi = xi or {}

---@enum xi.spawnType
xi.spawnType =
{
    NORMAL    = 0x00, -- 00:00-24:00
    ATNIGHT   = 0x01, -- 20:00-04:00
    ATEVENING = 0x02, -- 18:00-06:00
    WEATHER   = 0x04,
    FOG       = 0x08, -- 02:00-07:00
    MOONPHASE = 0x10,
    LOTTERY   = 0x20,
    WINDOWED  = 0x40,
    SCRIPTED  = 0x80, -- scripted spawn
}
