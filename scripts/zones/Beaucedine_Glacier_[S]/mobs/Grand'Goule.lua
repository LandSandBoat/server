------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Grand'Goule
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
