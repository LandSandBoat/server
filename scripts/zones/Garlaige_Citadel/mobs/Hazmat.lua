-----------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  5.839, y =  7.014, z =  197.462 }
}

entity.phList =
{
    [ID.mob.HAZMAT - 5] = ID.mob.HAZMAT,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 300)
end

return entity
