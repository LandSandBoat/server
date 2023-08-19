-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Dire Gargouille
-- Note: PH for Graoully
-----------------------------------
local ID = zones[xi.zone.XARCABARD_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GRAOULLY_PH, 10, 3600) -- 1 hour
end

return entity
