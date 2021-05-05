-----------------------------------
-- Area: Upper Jeuno
--  NPC: Migliorozz
-- Type: Standard NPC
-- !pos -37.760 -2.499 12.924 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10026)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
