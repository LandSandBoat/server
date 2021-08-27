-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Adjutant
-- Type: Standard NPC
-- !pos -67.819 -4.499 58.997 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(305)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
