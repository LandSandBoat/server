-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0zs
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL) or
        xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL, 'Status') == 6
    then
        player:startEvent(112)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 112 and option == 1 then
        player:setPos(-20, 0, -355, 192, 34)
    end
end

return entity
