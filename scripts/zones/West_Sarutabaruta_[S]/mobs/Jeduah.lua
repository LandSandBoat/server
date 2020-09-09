------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Jeduah
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 517)
end
