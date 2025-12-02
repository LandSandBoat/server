-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Bouncing Ball
-- Note: PH for Canal Moocher
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CANAL_MOOCHER, 10, 3600) -- 1 hour
end

return entity
