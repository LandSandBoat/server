-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (Red)
-- !pos -142.956 4.637 -173.018 160
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
