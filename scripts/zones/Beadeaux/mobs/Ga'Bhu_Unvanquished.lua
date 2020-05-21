------------------------------
-- Area: Beadeaux
--   NM: Ga'Bhu Unvanquished
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
