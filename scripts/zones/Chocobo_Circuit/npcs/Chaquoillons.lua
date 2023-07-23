-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Chaquoillons
-- !pos -270.716 -4.000 -465.199 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(238)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
