-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DEADLY_DODO - 2] = ID.mob.DEADLY_DODO, -- 238.000 40.000 332.000
    [ID.mob.DEADLY_DODO - 1] = ID.mob.DEADLY_DODO, -- 369.564 39.658 345.197
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 272)
    xi.magian.onMobDeath(mob, player, optParams, set{ 580 })
end

return entity
