-----------------------------------
-- Area: La Theine Plateau
--  Mob: Poison Funguar
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

local tumblingPHTable =
{
    [ID.mob.TUMBLING_TRUFFLE - 3] = ID.mob.TUMBLING_TRUFFLE, -- 450.472 70.657 238.237
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tumblingPHTable, 5, 3600) -- 1 hour minimum
end

return entity
