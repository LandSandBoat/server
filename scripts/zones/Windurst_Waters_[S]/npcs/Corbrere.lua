-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Corbrere
-- Type: Standard NPC
-- !pos -46.925 -4.5 49.006 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(414)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
