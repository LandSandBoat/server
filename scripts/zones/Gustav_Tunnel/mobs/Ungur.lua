-----------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 475)
end
