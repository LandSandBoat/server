-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gadimo
-- !pos -369.392 -4.000 -450.880 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308, 312, 313, 314, 315, 316, 320, 324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
