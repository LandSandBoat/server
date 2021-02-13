-----------------------------------
-- Area: Western Adoulin
--  NPC: Gorad
-- Type: Standard NPC
-- !pos 23 0 -115 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(542)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
