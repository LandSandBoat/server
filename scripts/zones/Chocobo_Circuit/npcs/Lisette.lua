-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Lisette
-- !pos -150.073 0.000 -377.292 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(348)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
