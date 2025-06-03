-----------------------------------
-- Area: Jugner Forest
--  NPC: Cavernous Maw
-- !pos -118 -8 -518 104
-- Teleports Players to Jugner Forest [S]
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
