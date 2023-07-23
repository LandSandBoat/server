-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Chuaie
-- Type: Adventurer's Assistant
-- !pos 231.384 -3 -531.830 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(18)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
