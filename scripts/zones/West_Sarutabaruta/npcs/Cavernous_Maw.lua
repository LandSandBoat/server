-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Cavernous Maw
-- Teleports Players to West Sarutabaruta [S]
-- !pos -2.229 0.001 -162.715 115
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
