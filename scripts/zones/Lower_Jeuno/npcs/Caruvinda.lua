-----------------------------------
-- Area: Lower Jeuno
--  NPC: Caruvinda
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 10046)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 10045)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 10045)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 10046, 10045)
end

return entity
