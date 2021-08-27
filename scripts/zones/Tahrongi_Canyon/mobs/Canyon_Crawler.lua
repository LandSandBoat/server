-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Canyon Crawler
-- Note: PH for Herbage Hunter
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 96, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HERBAGE_HUNTER_PH, 10, math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
