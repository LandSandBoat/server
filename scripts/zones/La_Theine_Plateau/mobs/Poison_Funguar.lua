-----------------------------------
-- Area: La Theine Plateau
--  Mob: Poison Funguar
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

local tumblingPHTable =
{
    [ID.mob.TUMBLING_TRUFFLE - 3] = ID.mob.TUMBLING_TRUFFLE, -- 450.472 70.657 238.237
}

local tumblingSpawnPoints =
{
    { x = 339.000, y = 56.000, z = 155.000 },
    { x = 384.000, y = 71.000, z = 205.000 },
    { x = 467.000, y = 71.000, z = 239.000 },
    { x = 528.000, y = 70.000, z = 278.000 },
    { x = 592.000, y = 59.000, z = 297.000 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = tumblingSpawnPoints
    xi.mob.phOnDespawn(mob, tumblingPHTable, 5, 3600, params) -- 1 hour minimum
end

return entity
