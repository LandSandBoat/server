------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
