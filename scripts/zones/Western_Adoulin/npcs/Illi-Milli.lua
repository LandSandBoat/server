-----------------------------------
-- Area: Western Adoulin
--  NPC: Illi-Milli
-- Type: Standard NPC
-- !pos 170 4 -5 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(568)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
