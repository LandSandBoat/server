-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Fulchia
-- !pos 158.522 -1.999 164.928 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(893, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
