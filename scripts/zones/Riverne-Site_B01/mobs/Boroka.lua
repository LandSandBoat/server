-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.BOROKA_BELEAGUERER)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hour respawn
end
