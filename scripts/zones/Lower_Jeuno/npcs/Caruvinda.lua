-----------------------------------
-- Area: Lower Jeuno
--  NPC: Caruvinda
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 10046)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 10045)
end

entity.onEventUpdate = function(player, csid, option)
    xi.armorStorage.onEventUpdate(player, csid, option, 10045)
end

entity.onEventFinish = function(player, csid, option)
    xi.armorStorage.onEventFinish(player, csid, option, 10046, 10045)
end

return entity
