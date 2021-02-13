-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern
-- !pos 12.993 24.746 -296.651 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternHaku(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end

return entity
