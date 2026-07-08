-----------------------------------
-- Area: Windurst Walls
--  NPC: Trail Markings
-- Dynamis-Windurst Enter
-- !pos -216 0 -94 239
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
