-----------------------------------
-- Area: Windurst Woods
--  NPC: Tesch_Garanjy
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 10027)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 10028)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 10028)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 10027, 10028)
end

return entity
