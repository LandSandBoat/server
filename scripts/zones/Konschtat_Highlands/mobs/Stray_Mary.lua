-----------------------------------
-- Area: Konschtat Highlands
--   NM: Stray Mary
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -212.268, y =  39.477, z =  329.581 }
}

entity.phList =
{
    [ID.mob.STRAY_MARY[1] - 4] = ID.mob.STRAY_MARY[1], -- -305.204 -11.695 -96.078
    [ID.mob.STRAY_MARY[2] - 5] = ID.mob.STRAY_MARY[2], -- -293.900  33.393 342.710
}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 203)
    player:addTitle(xi.title.MARYS_GUIDE)
    xi.tutorial.onMobDeath(player)
    xi.magian.onMobDeath(mob, player, optParams, set{ 710 })
end

return entity
