-----------------------------------
-- Area: Windurst Walls
--  NPC: Chawo Shipeynyo
-- Type: Standard NPC
-- !pos 3.593 -17 124.069 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
