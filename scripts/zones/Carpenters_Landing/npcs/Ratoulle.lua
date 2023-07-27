-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Ratoulle
-- Type: Adventurer's Assistant
-- !pos -133.959 -3 60.839 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(19)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
