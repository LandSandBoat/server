-----------------------------------
-- Area: Western Adoulin
--  NPC: Delionna
-- Type: Standard NPC
-- !pos 16 0 165 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(561)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
