-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Roman
-- !pos -386.263 -4.000 -508.572 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287, 291, 295, 296, 297, 298, 300, 304)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
