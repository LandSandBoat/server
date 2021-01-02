------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Tiffenotte
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 520)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 8400)) -- 2 hours to 2 hours, 20 minutes
end
