------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
