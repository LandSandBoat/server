-----------------------------------
-- Area: Jugner Forest [S]
--  NPC: Cavernous Maw
-- !pos -118 -8 -520 82
-- Teleports Players to Jugner Forest
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.maws.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.maws.onEventFinish(player, csid, option, npc)
end

return entity
