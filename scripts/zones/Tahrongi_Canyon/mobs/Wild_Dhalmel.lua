-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Wild Dhalmel
-- Note: PH for Serpopard Ishtar
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 96, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SERPOPARD_ISHTAR_PH, 10, 3600) -- 1 hour
end

return entity
