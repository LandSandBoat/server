-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ratonne
-- Armor Storage NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 510)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 511)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.armorStorage.onEventUpdate(player, csid, option, 511)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.armorStorage.onEventFinish(player, csid, option, 510, 511)
end

return entity
