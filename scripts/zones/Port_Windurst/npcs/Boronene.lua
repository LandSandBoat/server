-----------------------------------
-- Area: Port Windurst
--  NPC: Boronene
-- !pos 201.651 -12.000 229.584 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(638, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
