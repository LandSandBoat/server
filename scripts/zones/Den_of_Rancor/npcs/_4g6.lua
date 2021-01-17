-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (SE)
-- !pos -59 45 24 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternChamber(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end

return entity
