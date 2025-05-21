-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

local citipatiPHTable =
{
    [ID.mob.CITIPATI - 7] = ID.mob.CITIPATI, -- -328.973 -12.876 67.481
    [ID.mob.CITIPATI - 4] = ID.mob.CITIPATI, -- -398.931 -4.536 79.640
    [ID.mob.CITIPATI - 1] = ID.mob.CITIPATI, -- -381.284 -9.233 40.054
}

local citiSpawnPoints =
{
    { x = -364.014, y = -4.634,  z = -2.627 },
    { x = -328.973, y = -12.876, z = 67.481 },
    { x = -398.931, y = -4.536,  z = 79.640 },
    { x = -381.284, y = -9.233,  z = 40.054 },
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.nightOnly = true
    params.spawnPoints = citiSpawnPoints
    xi.mob.phOnDespawn(mob, citipatiPHTable, 20, math.random(10800, 21600), params) -- 3 to 6 hours, night only
end

return entity
