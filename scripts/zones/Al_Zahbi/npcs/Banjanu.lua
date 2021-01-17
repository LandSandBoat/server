-----------------------------------
-- Area: Al Zahbi
--  NPC: Banjanu
-- Type: Standard NPC
-- !pos -75.954 0.999 105.367 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(262)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
