-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Buburimboo
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BUBURIMBOO - 1] = ID.mob.BUBURIMBOO, -- 442.901 19.500 109.075
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 261)
    xi.magian.onMobDeath(mob, player, optParams, set{ 645 })
end

return entity
