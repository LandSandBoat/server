-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Trail Markings
-- Dynamis-Beaucedine Enter
-- !pos -284 -39 -422 111
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
