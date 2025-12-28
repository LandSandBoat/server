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

entity.spawnPoints =
{
    { x =  168.000, y =  0.000, z = -440.000 }
}

entity.phList =
{
    [ID.mob.GOBLINTRAP - 1] = ID.mob.GOBLINTRAP, -- 156 0 -438
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 481)
end

return entity
