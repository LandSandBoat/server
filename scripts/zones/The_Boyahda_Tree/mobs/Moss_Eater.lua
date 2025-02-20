-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Moss Eater
-- Note: PH for Unut
-- TODO: 3 PHs should be in a spawning group that only one of them can be up at a time
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

local unutPHTable =
{
    [ID.mob.UNUT - 13] = ID.mob.UNUT, -- 127.32 7.768 93.138
    [ID.mob.UNUT - 9]  = ID.mob.UNUT, -- 97.774 7.837 67.815
    [ID.mob.UNUT - 2]  = ID.mob.UNUT, -- 60.408 8.711 82.500
}

local unutSpawnPoints =
{
    { x = 104.340, y = 8.423, z = 81.217 },
    { x = 109.771, y = 8.673, z = 74.235 },
    { x = 120.899, y = 8.843, z = 77.341 },
    { x = 123.823, y = 8.668, z = 91.314 },
    { x = 105.215, y = 8.356, z = 97.292 },
    { x =  92.628, y = 7.221, z = 97.590 },
    { x =  91.597, y = 8.326, z = 85.349 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 721, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.spawnPoints = unutSpawnPoints
    xi.mob.phOnDespawn(mob, unutPHTable, 5, 7200, params) -- 2 hours
end

return entity
