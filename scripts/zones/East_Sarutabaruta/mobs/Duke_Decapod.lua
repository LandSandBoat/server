-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Duke Decapod
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 255)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end
