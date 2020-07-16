------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Muscleman
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 246)
end
