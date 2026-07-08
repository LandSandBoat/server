-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Trail Markings
-- Dynamis-San d'Oria Enter
-- !pos 139 -2 122 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.dynamis.entryNpcOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.dynamis.entryNpcOnEventFinish(player, csid, option, npc)
end

return entity
