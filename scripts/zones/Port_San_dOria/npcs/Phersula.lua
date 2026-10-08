-----------------------------------
-- Area: Port San d'Oria
--  NPC: Phersula
-- !pos 80.316 -15.999 -134.112 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(775, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
