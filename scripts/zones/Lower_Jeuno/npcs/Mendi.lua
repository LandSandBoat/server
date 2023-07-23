-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mendi
-- Reputation NPC
-- !pos -55 5 -68 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(82, player:getFame(xi.quest.fame_area.JEUNO))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
