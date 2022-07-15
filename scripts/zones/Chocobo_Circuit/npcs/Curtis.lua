-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Curtis
-- Race Attendant (Orange)
-- pos -276.635 0.004 -533.735
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(211)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
