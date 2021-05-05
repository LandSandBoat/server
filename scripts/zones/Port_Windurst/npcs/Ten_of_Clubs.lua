-----------------------------------
-- Area: Port Windurst
--  NPC: Ten of Clubs
-- Type: Standard NPC
-- !pos -229.393 -9.2 182.696 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(75)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
