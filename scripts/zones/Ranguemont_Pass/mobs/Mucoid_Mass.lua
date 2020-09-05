-----------------------------------
-- Area: Ranguemont Pass
--   NM: Mucoid Mass
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 345)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
end
