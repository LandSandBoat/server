-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Jaicedion
-- Standard Info NPC
-- pos -39.9824 -15.0000 -132.5794
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(336)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
