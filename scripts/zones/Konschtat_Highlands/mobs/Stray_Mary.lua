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
    [ID.mob.STRAY_MARY[1] - 4] = ID.mob.STRAY_MARY[1], -- Confirmed on retail
    [ID.mob.STRAY_MARY[2] - 5] = ID.mob.STRAY_MARY[2], -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.MARYS_GUIDE)
        xi.hunts.checkHunt(mob, player, 203)
        xi.tutorial.onMobDeath(player)
        xi.magian.onMobDeath(mob, player, optParams, set{ 710 })
    end
end

return entity
