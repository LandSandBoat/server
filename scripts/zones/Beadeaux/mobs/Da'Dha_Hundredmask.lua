------------------------------
-- Area: Beadeaux
--   NM: Da'Dha Hundredmask
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 241)
end
