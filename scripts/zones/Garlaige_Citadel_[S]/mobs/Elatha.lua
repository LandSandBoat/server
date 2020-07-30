------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Elatha
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 535)
end
