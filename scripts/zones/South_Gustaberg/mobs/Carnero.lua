------------------------------
-- Area: South Gustaberg
--   NM: Carnero
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 202)
end
