-----------------------------------
-- Area: Valkurm Dunes (103)
--   NM: Golden Bat
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 208)
end
