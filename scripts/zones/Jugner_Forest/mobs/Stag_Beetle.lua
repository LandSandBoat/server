-----------------------------------
-- Area: Jugner Forest
--  Mob: Stag Beetle
-- Note: PH for Panzer Percival
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 12, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 13, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PANZER_PERCIVAL_PH, 10, 1) -- No minimum respawn
end

return entity
