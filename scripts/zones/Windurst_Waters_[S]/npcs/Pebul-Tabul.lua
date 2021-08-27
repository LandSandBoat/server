-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pebul-Tabul
-- Type: Standard NPC
-- !pos -68.500 -4.5 3.694 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(405)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
