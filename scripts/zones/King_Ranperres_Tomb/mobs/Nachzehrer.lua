-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Nachzehrer
-- Note: PH for Gwyllgi
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GWYLLGI, 10, 3600) -- 1 hour
end

return entity
