-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Battrap
-- Note: PH for Goblintrap
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GOBLINTRAP, 5, 3600) -- 1 hour
end

return entity
