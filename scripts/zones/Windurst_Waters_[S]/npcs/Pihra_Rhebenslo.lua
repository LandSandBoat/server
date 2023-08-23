-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Pihra_Rhebenslo
-- Armor Storage NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 442)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 443)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.armorStorage.onEventUpdate(player, csid, option, 443)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.armorStorage.onEventFinish(player, csid, option, 442, 443)
end

return entity
