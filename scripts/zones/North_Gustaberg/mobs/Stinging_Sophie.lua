------------------------------
-- Area: North Gustaberg
--   NM: Stinging Sophie
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 197)
end
