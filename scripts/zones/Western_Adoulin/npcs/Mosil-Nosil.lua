-----------------------------------
-- Area: Western Adoulin
--  NPC: Mosil-Nosil
-- Type: Standard NPC
-- !pos -45 0 -29 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(513)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
