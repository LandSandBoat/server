------------------------------
-- Area: Newton Movalpolos
--   NM: Swashstox Beadblinker
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 247)
end
