-----------------------------------
-- Area: Xarcabard
--  Mob: Evil Eye
-- Note: PH for Shadow Eye
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 53, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 54, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 55, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SHADOW_EYE, 5, 3600) -- 1 hour
end

return entity
