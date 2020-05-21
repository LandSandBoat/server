------------------------------
-- Area: Beadeaux
--   NM: Zo'Khu Blackcloud
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
