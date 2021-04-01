-----------------------------------
-- Area: La Theine Plateau
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.YILBEGAN_HIDEFLAYER)
    xi.tutorial.onMobDeath(player)
end

return entity
