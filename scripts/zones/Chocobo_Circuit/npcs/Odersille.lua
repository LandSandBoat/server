-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Odersille
-- !pos -11.523 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(331, 4) --Saffaullette
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
end

return entity
