-----------------------------------
-- Area: Xarcabard
--  NPC: Trail Markings
-- Dynamis-Xarcabard Enter
-- !pos 570 0 -272 112
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
