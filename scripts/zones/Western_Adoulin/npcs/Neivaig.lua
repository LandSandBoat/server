-----------------------------------
-- Area: Western Adoulin
--  NPC: Neivaig
-- Type: Standard NPC
-- !pos -4 3 73 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(556)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
