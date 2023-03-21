-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Olega
-- !pos -264.991 -4.000 -508.379 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267, 271, 275, 279, 283, 284, 285, 286)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
