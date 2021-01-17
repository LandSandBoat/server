-----------------------------------
-- Area: Western Adoulin
--  NPC: Orenna
-- Type: Standard NPC
-- !pos -30 0 -26 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(512)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
