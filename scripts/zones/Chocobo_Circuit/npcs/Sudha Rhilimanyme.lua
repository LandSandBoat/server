-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Sudha Rhilimanyme
-- !pos -264.944 -4.000 -451.760 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267, 271, 272, 273, 274, 275, 279, 273)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
