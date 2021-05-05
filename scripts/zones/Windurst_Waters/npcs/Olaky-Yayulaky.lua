-----------------------------------
-- Area: Windurst Waters
--  NPC: Olaky-Yayulaky
-- Type: Item Depository
-- !pos -61.247 -4.5 72.551 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(910)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
