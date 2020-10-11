------------------------------
-- Area: Aydeewa Subterrane
--   NM: Bluestreak Gyugyuroon
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 464)
end
