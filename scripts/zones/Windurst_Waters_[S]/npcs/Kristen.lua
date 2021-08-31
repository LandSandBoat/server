-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kristen
-- Type: Standard NPC
-- !pos 2.195 -2 60.296 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(404)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
