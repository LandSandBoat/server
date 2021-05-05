-----------------------------------
-- Area: Windurst Waters
--  NPC: Ten of Hearts
-- Type: Standard NPC
-- !pos -49.441 -5.909 226.524 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(107)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
