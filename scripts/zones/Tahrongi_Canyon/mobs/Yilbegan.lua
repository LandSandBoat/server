-----------------------------------
-- Area: Tahrongi Canyon
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
    tpz.tutorial.onMobDeath(player)
end

return entity
