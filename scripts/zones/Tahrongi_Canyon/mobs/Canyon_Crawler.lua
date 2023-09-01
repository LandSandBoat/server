-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Canyon Crawler
-- Note: PH for Herbage Hunter
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 96, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HERBAGE_HUNTER_PH, 10, 3600) -- 1 hour minimum
end

return entity
