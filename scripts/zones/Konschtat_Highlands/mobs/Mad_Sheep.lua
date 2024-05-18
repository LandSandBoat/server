-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Mad Sheep
-- Note: Place holder Stray Mary
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

local strayMaryPHTable =
{
    [ID.mob.STRAY_MARY[1] - 4] = ID.mob.STRAY_MARY[1], -- -305.204 -11.695 -96.078
    [ID.mob.STRAY_MARY[2] - 5] = ID.mob.STRAY_MARY[2], -- -293.900  33.393 342.710
}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, strayMaryPHTable, 5, 300) -- 5 minute minimum
end

return entity
