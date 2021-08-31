-----------------------------------
-- Area: Western Adoulin
--  NPC: Behff Oibbah
-- Type: Standard NPC
-- !pos 81 0 -17 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(514)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
