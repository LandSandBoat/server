-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Romaa Mihgo
-- !pos -1.967 -3 -26.337 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
