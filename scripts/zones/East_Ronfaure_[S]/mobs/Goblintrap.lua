-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Goblintrap
-- Note: Goblintrap NM
-- !pos 168 0 -440 81
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GOBLINTRAP - 1] = ID.mob.GOBLINTRAP, -- 156 0 -438
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 481)
end

return entity
