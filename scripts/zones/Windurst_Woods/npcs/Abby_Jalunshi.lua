-----------------------------------
-- Area: Windurst Woods
--  NPC: Abby Jalunshi
-- !pos -101.895 -4.000 36.172 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(798, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
