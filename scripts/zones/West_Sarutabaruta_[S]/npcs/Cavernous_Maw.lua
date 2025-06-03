-----------------------------------
-- Area: West Sarutabaruta [S]
--  NPC: Cavernous Maw
-- !pos 0 0 -165 95
-- Teleports Players to West Sarutabaruta
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
