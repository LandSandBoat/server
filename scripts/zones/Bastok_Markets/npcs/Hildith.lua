-----------------------------------
-- Area: Bastok Markets
--  NPC: Hildith
-- Type: Room Renters
-- !pos -176.664 -9 25.158 235
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(488)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
