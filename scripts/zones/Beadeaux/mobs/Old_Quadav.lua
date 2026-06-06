-----------------------------------
-- Area: Beadeaux
--  Mob: Old Quadav
-- PH for Ge'Dha Evileye
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GE_DHA_EVILEYE, 25, 3600) -- 1 hour
end

return entity
