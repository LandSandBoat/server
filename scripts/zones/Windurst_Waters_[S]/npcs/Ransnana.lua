-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ransnana
-- Type: Standard NPC
-- !pos -22.008 -13.339 122.819 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(408)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
