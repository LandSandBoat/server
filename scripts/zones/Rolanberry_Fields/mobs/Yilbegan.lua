-----------------------------------
-- Area: Rolanberry Fields
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
end
