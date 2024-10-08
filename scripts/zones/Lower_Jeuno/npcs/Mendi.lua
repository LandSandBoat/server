-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mendi
-- Reputation NPC
-- !pos -55 5 -68 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(82, player:getFame(xi.fameArea.JEUNO))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
