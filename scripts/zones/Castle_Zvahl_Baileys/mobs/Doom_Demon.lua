-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Doom Demon
-- Note: PH for Marquis Sabnock
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

local sabnockSpawnPoints =
{
    { x = 70.800, y = -8.000, z = -119.500 },
    { x = 63.285, y = -8.000, z = -102.540 },
    { x = 80.141, y = -8.000, z =  -99.397 },
    { x = 96.419, y = -8.000, z = -118.788 },
    { x = 91.070, y = -8.000, z = -138.734 },
    { x = 74.301, y = -8.000, z = -131.159 },
    { x = 84.099, y = -8.000, z = -121.188 },
    { x = 77.088, y = -8.000, z = -113.123 },
    { x = 68.494, y = -8.000, z = -117.972 },
}

local sabnockPHTable =
{
    [ID.mob.MARQUIS_SABNOCK + 1] = ID.mob.MARQUIS_SABNOCK,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, sabnockPHTable, 10, 7200, { spawnPoints = sabnockSpawnPoints }) -- 2 hour
end

return entity
