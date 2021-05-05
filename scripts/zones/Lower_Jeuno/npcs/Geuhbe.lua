-----------------------------------
-- Area: Lower Jeuno
--  NPC: Geuhbe
-- Type: Event Scene Replayer
-- !pos -74.309 -1 -114.174 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10033)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
