-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Upital-Lupital
-- Type: Standard NPC
-- !pos -57.809 -13.339 122.753 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(439)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
