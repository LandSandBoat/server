-----------------------------------
-- Area: West Ronfaure (100)
--   NM: Jaggedy-Eared Jack
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.JAGGEDY_EARED_JACK - 1] = ID.mob.JAGGEDY_EARED_JACK -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 148)
end

return entity
