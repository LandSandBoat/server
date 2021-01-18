-----------------------------------
-- Area: Al Zahbi
--  NPC: Salaifa
-- Type: Standard NPC
-- !pos -37.462 -7 -41.665 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(237)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
