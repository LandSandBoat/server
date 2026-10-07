-----------------------------------
-- Area: Windurst Walls
--  NPC: Shinchai-Tocchai
-- !pos -220.551 0.999 -116.916 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(505, player:getNation())
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
end

return entity
