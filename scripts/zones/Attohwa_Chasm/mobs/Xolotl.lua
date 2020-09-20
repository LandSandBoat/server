-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    mob:setRespawnTime(0, true)
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.XOLOTL_XTRAPOLATOR)
end

function onMobDespawn(mob)
    -- Do not respawn Xolotl for 21-24 hours
    mob:setRespawnTime(math.random(75600, 86400), true)
end
