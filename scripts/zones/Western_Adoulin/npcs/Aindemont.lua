-----------------------------------
-- Area: Western Adoulin
--  NPC: Aindemont
-- Type: Standard NPC
-- !pos 171 4 -33 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(569)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
