------------------------------
-- Area: Xarcabard [S]
--   NM: Tikbalang
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 540)
end
