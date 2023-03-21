-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Maleroune
-- !pos -380.827 -4.000 -508.221 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287, 291, 295, 300, 301, 302, 303, 304)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
