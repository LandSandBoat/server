-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Koropokkur
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 361)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 5400)) -- 60-90min repop
end
