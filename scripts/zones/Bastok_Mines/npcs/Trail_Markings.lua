-----------------------------------
-- Area: Bastok Mines
--  NPC: Trail Markings
-- Dynamis-Bastok Enter
-- !pos 99 1 -67 234
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
