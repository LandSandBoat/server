-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0zs
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    return 1
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL) then
        player:startEvent(112)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 112 and option == 1 then
        player:setPos(-20, 0, -355, 192, 34)
    end
end

return entity
