-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Failene
-- !pos -311.080 -4.000 -413.251 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212, 213, 214, 215, 220, 224, 228, 235)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
