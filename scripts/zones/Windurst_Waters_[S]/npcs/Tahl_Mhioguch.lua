-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Tahl Mhioguch
-- Type: Standard NPC
-- !pos -64.907 -5.947 81.391 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(438)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
