-----------------------------------
-- Area: Western Adoulin
--  NPC: Orfbis
-- Type: Standard NPC
-- !pos -13 0 -44 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(523)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
