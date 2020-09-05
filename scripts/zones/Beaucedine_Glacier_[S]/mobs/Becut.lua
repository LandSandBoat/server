------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Becut
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 537)
end
