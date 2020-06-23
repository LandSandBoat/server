------------------------------
-- Area: Beadeaux
--   NM: Ge'Dha Evileye
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 240)
end
