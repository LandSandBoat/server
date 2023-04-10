-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Cyril
-- !pos -331.617 0.000 -467.548 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
