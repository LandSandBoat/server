-----------------------------------
-- Area: La Theine Plateau
--  Mob: Poison Funguar
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TUMBLING_TRUFFLE_PH, 5, 3600) -- 1 hour minimum
end

return entity
