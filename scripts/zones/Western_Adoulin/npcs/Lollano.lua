-----------------------------------
-- Area: Western Adoulin
--  NPC: Lollano
-- Type: Standard NPC
-- !pos 96 0 -13 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(516)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
