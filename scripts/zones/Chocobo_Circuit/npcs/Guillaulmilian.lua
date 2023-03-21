-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Guillaulmilian
-- !pos -380.984 -4.000 -451.755 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308, 312, 316, 320, 321, 322, 323, 324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
