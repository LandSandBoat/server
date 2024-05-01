-----------------------------------
-- Area: Xarcabard
--  Mob: Evil Eye
-- Note: PH for Shadow Eye
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}

local shadowEyePHTable =
{
    [ID.mob.SHADOW_EYE - 6] = ID.mob.SHADOW_EYE,
    [ID.mob.SHADOW_EYE - 5] = ID.mob.SHADOW_EYE,
    [ID.mob.SHADOW_EYE - 4] = ID.mob.SHADOW_EYE,
    [ID.mob.SHADOW_EYE - 3] = ID.mob.SHADOW_EYE,
    [ID.mob.SHADOW_EYE - 2] = ID.mob.SHADOW_EYE,
    [ID.mob.SHADOW_EYE - 1] = ID.mob.SHADOW_EYE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 53, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 54, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 55, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, shadowEyePHTable, 5, 3600) -- 1 hour
end

return entity
