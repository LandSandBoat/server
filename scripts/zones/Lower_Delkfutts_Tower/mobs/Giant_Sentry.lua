-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Giant Sentry
-- Note: PH for Hippolytos and Eurymedon
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 778, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HIPPOLYTOS_PH, 5, 1) -- no cooldown
    xi.mob.phOnDespawn(mob, ID.mob.EURYMEDON_PH, 5, 1) -- no cooldown
end

return entity
