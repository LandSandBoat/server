-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Ove
-- !pos -160.484 0.000 -374.533 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(353)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
