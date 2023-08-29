-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (Blue)
-- !pos -136.840 4.742 -173.040 160
-----------------------------------
local denOfRancorGlobal = require('scripts/zones/Den_of_Rancor/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    denOfRancorGlobal.onTradeLanternBoss(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    denOfRancorGlobal.onTriggerLantern(player, npc)
end

return entity
