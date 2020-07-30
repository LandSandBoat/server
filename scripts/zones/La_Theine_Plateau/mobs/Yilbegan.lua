-----------------------------------
-- Area: La Theine Plateau
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
    tpz.tutorial.onMobDeath(player)
end
