-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (SW)
-- !pos -59 45 24 160
-----------------------------------
local denOfRancorGlobal = require('scripts/zones/Den_of_Rancor/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    denOfRancorGlobal.onTradeLanternChamber(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    denOfRancorGlobal.onTriggerLantern(player, npc)
end

return entity
