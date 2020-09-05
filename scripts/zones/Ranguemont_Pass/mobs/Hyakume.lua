------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 344)
end
