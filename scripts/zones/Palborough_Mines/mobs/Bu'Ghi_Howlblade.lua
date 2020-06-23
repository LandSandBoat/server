------------------------------
-- Area: Palborough Mines
--   NM: Bu'Ghi Howlblade
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 219)
end
