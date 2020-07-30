-----------------------------------
-- Area: East Ronfaure (101)
--   NM: Bigmouth Billy
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 151)
end
