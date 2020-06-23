------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 215)
end
