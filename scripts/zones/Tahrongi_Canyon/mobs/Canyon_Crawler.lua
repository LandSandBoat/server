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

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 96, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HERBAGE_HUNTER_PH, 10, math.random(3600, 7200)) -- 1 to 2 hours
end
