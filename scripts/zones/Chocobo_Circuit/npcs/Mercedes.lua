-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Mercedes
-- !pos -363.256 0.004 -533.551 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(343)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
