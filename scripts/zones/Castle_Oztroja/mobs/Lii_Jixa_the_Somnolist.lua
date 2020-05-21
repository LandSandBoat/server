-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Lii Jixa the Somnolist
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60 to 90 minutes
end
