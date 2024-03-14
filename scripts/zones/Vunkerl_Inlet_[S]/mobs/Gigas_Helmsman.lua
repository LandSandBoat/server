-----------------------------------
-- Area: Vunkerl Inlet [S]
--   Mob: Gigas Helmsman
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 489)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PALLAS_S_PH, 5, 3600) -- 1 hour
end

return entity
