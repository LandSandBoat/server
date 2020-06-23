------------------------------
-- Area: Palborough Mines
--   NM: Be'Hya Hundredwall
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 222)
end
