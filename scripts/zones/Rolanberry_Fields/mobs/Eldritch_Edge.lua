------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 218)
end
