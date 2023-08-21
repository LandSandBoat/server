-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Raptor
-- Note: PH for Daggerclaw Dracos
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DAGGERCLAW_DRACOS_PH, 10, 3600) -- 1 hour
end

return entity
