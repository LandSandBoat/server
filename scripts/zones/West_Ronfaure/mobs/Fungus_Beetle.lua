-----------------------------------
-- Area: West Ronfaure (100)
--   NM: Fungus Beetle
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 147)
end
