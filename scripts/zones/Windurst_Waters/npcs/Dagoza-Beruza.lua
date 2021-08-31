-----------------------------------
-- Area: Windurst Waters
--  NPC: Dagoza-Beruza
-- Type: Mission NPC
-- !pos -54.523 -6 229.271 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(104)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
