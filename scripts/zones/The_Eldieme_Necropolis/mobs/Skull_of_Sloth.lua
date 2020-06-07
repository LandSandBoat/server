------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Sloth
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
