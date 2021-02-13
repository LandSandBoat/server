-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (Blue)
-- !pos -136.840 4.742 -173.040 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternBoss(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end

return entity
