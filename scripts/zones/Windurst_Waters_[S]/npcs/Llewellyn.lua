-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Llewellyn
-- Type: Campaign Evaluator
-- !pos -6.907 -2 42.871 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
