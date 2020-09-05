-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Krabkatoa
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.KRABKATOA_STEAMER)
end
