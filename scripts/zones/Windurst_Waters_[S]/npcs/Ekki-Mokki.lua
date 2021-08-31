-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ekki-Mokki
-- Type: Standard NPC
-- !pos -26.558 -4.5 62.930 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(409)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
