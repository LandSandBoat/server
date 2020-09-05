------------------------------
-- Area: Mount Zhayolm
--   NM: Fahrafahr the Bloodied
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 458)
end
