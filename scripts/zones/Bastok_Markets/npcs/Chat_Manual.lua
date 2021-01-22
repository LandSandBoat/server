-----------------------------------
-- Area: Bastok Markets
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos -309.989 -10.004 -116.634 235
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6106)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
