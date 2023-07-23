-----------------------------------
-- Area: Upper Jeuno
--  NPC: Turlough
-- Mission NPC
-- !pos -58.697 0.000 103.553 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10158) -- default dialogue
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
