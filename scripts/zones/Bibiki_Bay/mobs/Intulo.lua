-----------------------------------
-- Area: Bibiki Bay
--   NM: Intulo
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  523.000, y = -8.000, z =  762.000 }
}

entity.phList =
{
    [ID.mob.INTULO - 1] = ID.mob.INTULO,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 265)
    xi.magian.onMobDeath(mob, player, optParams, set{ 71, 285, 433 })
end

return entity
