------------------------------
-- Area: East Ronfaure [S]
--   NM: Skogs Fru
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 479)
end
