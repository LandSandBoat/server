-----------------------------------
-- Area: Bastok Mines
--  NPC: Leonie
-- !pos 118.871 0.996 -83.916 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(568, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
