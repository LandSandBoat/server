-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Valerio
-- !pos -502.155 0.000 -360.685 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(351)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
end

return entity
