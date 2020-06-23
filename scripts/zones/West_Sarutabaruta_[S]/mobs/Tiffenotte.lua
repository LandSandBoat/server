------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Tiffenotte
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 520)
end
