-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Azainnie
-- Grandstand Exit
-- pos -62.2576 -15.0000 -132.6927
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(328)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
