-----------------------------------
-- Area: North Gustaberg [S]
--  NPC: Cavernous Maw
-- !pos 466 0 479 88
-- Teleports Players to North Gustaberg
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
