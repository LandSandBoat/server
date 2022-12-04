-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Perdric
-- !pos -84.007 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330, 3) --Mulaitrand
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
end

return entity
