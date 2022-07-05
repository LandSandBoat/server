-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Joilevin
-- Standard Info NPC
-- POS: -321.3047 0.0000 -467.5230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(236)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
