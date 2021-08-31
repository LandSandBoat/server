-----------------------------------
-- Area: Western Adoulin
--  NPC: Nargoht
-- Type: Standard NPC
-- !pos 25 0 117 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(557)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
