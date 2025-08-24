-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Skogs Fru
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SKOGS_FRU- 70] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 32] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 31] = ID.mob.SKOGS_FRU,
    [ID.mob.SKOGS_FRU- 30] = ID.mob.SKOGS_FRU,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 479)
end

return entity
