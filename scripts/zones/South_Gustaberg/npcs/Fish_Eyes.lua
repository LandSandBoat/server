-----------------------------------
-- Area: South Gustaberg
--  NPC: Fish Eyes
-- Type: Goldfish Scooping
-- !pos -444.459 39.106 -390.885 107
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(903)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
