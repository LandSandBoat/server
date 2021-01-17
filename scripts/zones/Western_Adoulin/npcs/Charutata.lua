-----------------------------------
-- Area: Western Adoulin
--  NPC: Charutata
-- Type: Standard NPC
-- !pos -17 0 -90 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(536)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
