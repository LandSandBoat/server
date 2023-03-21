-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Laujaquetemps
-- !pos -311.232 -4.000 -430.437 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212, 213, 214, 215, 217, 221, 228, 232)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
