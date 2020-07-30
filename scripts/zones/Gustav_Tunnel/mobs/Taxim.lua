-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 424)
end
