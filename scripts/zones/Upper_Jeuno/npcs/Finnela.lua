-----------------------------------
-- Area: Upper Jeuno
--  NPC: Finnela
-- Type: Standard NPC
-- !pos -51.880 -1 106.486 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10125)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
