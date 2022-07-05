-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Perdric
-- Grandstand Exit
-- pos -84.5186 -15.0901 129.1561
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
