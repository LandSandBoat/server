-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Goblintrap
-- Note: Goblintrap NM
-- !pos 168 0 -440 81
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 481)
end
