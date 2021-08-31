-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Amfafa
-- Type: Standard NPC
-- !pos -24.938 -2 -185.729 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(433)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
