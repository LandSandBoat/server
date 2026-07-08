-----------------------------------
-- Area: La Theine Plateau
--  NPC: Goblin Footprint
-- !pos  -546.156 -3.934 651.590 102
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.goblinfootprint.rewatch(player)
end

entity.onTrigger = function(player, npc)
    xi.goblinfootprint.rewatch(player, true)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.goblinfootprint.startEvent(player, csid, option, npc)
end

return entity
