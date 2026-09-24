-----------------------------------
-- Area: East Ronfaure (101)
--   NM: Bigmouth Billy
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BIGMOUTH_BILLY - 2] = ID.mob.BIGMOUTH_BILLY, -- 453.625 -18.436 -127.048
    [ID.mob.BIGMOUTH_BILLY - 1] = ID.mob.BIGMOUTH_BILLY, -- 403.967 -36.822 -16.285
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 151)
end

return entity
