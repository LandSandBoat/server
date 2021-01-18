-----------------------------------
-- Area: Western Adoulin
--  NPC: Katya
-- Type: Standard NPC
-- !pos 11 0 68 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(559)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
