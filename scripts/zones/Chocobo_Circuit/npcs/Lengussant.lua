-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Lengussant
-- !pos -258.943 -4.000 -508.155 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287, 288, 289, 290, 291, 295, 300, 304)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
