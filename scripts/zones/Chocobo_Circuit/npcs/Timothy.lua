-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Timothy
-- !pos -135.653 0.000 -538.552 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(349)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
