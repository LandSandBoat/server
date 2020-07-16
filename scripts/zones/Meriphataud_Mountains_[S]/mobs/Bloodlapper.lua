------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Bloodlapper
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 526)
end
