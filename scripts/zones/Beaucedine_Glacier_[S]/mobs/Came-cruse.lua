------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Came-cruse
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 536)
end
