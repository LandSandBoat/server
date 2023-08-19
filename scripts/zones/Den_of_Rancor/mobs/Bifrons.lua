-----------------------------------
-- Area: Den of Rancor
--  Mob: Bifrons
-- Note: PH for Friar Rush
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FRIAR_RUSH_PH, 10, 3600) -- 1 hour
end

return entity
