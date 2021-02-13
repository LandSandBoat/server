-----------------------------------
-- Area: Phanauet Channel
--  NPC: Ineuteniace
-- Type: Standard NPC
-- !pos 11.701 -3 1.360 1
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(101)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
