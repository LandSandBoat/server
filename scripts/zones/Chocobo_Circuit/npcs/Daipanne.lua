-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Daipanne
-- !pos -386.511 -4.000 -451.431 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308, 312, 316, 320, 324, 325, 326, 327)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
