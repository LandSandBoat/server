------------------------------
-- Area: Xarcabard [S]
--   NM: Prince Orobas
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 541)
end
