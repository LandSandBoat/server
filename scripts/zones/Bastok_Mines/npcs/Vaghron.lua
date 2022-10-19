-----------------------------------
-- Area: Bastok Mines
--  NPC: Vaghron
-- Type: Adventurer's Assistant
-- !pos -39.162 -1 -92.147 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(118)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
