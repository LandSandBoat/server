-----------------------------------
-- Area: Al Zahbi
--  NPC: Gaweesh
-- Type: Najelith's Attendant
-- !pos -64.537 -8 37.928 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(258)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
