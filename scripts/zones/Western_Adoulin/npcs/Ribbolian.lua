-----------------------------------
-- Area: Western Adoulin
--  NPC: Ribbolian
-- Type: Standard NPC
-- !pos 21 1 -27 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(518)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
