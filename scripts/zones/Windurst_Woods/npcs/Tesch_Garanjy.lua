-----------------------------------
-- Area: Windurst Woods
--  NPC: Tesch_Garanjy
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 10027)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 10028)
end

entity.onEventUpdate = function(player, csid, option)
    xi.armorStorage.onEventUpdate(player, csid, option, 10028)
end

entity.onEventFinish = function(player, csid, option)
    xi.armorStorage.onEventFinish(player, csid, option, 10027, 10028)
end

return entity
