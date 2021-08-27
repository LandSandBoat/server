-----------------------------------
-- Area: Port Windurst
--  NPC: Nine of Clubs
-- Type: Standard NPC
-- !pos -229.699 -9 185.686 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(74)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
