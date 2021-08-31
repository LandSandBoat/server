-----------------------------------
-- Area: Western Adoulin
--  NPC: Coltrone
-- Type: Standard NPC
-- !pos -30 19 97 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(555)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
