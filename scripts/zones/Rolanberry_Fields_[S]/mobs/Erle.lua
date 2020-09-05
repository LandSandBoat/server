------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Erle
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 512)
end
