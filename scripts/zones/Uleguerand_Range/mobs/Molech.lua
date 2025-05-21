-----------------------------------
-- Area: Uleguerand Range
--  Mob: Molech
-- Note: PH for Magnotaur
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

local magnotaurPHTable =
{
    [ID.mob.MAGNOTAUR - 2] = ID.mob.MAGNOTAUR,
    [ID.mob.MAGNOTAUR - 1] = ID.mob.MAGNOTAUR,
}

local magnotaurSpawnPoints =
{
    { x = -254.694, y = -185.189, z = 454.681 },
    { x = -250.987, y = -184.423, z = 446.010 },
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = magnotaurSpawnPoints
    xi.mob.phOnDespawn(mob, magnotaurPHTable, 10, 3600, params) -- 1 hour
end

return entity
