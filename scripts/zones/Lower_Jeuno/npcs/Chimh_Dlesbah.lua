-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chimh Dlesbah
-- Type: Event Scene Replayer
-- !pos -71.995 -1 -115.882 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10096)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
