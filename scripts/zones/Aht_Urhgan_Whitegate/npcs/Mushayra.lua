-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mushayra
-- Type: Standard NPC
-- !pos -111.551 -6.999 -61.720 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(519)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
