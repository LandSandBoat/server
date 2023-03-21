-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gerlbotz
-- !pos -369.336 -4.000 -508.927 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308, 309, 310, 311, 312, 316, 320, 324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
