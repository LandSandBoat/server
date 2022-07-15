-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Valerio
-- Teleporter
-- pos -500.0432 0.0000 -360.1892
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(351)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
