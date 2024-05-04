-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Wild Dhalmel
-- Note: PH for Serpopard Ishtar
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

local serpopardPHTable =
{
    [ID.mob.SERPOPARD_ISHTAR[1] - 3] = ID.mob.SERPOPARD_ISHTAR[1], -- -9.176 -8.191 -64.347 (south)
    [ID.mob.SERPOPARD_ISHTAR[2] - 4] = ID.mob.SERPOPARD_ISHTAR[2], -- 22.360 23.757 281.584 (north)
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 96, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, serpopardPHTable, 10, 3600) -- 1 hour
end

return entity
