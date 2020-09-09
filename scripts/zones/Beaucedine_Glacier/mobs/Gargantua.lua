------------------------------
-- Area: Beaucedine Glacier
--   NM: Gargantua
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 312)
end
