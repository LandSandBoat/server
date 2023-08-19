-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Nachzehrer
-- Note: PH for Gwyllgi
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GWYLLGI_PH, 10, 3600) -- 1 hour
end

return entity
