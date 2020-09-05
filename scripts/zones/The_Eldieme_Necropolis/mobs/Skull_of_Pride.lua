------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Pride
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 188)
end
