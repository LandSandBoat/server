-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Piana
-- !pos -374.898 -4.000 -451.831 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308, 312, 316, 317, 318, 318, 320, 324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
