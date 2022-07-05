-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Manfred
-- Race Attendant (Green)
-- pos
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(225)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
