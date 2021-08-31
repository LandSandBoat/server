-----------------------------------
-- Area: Western Adoulin
--  NPC: Safrick
-- Type: Standard NPC
-- !pos 26 0 69 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(551)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
