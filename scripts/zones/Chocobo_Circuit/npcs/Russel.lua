-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Russel
-- Race Attendant (Blue)
-- pos
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(227)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
