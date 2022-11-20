-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Particle Gate
-- !pos 1 0.1 -320 34
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.A_FATE_DECIDED and
        player:getCharVar("PromathiaStatus") == 0
    then
        player:startEvent(2)
    else
        player:startEvent(56)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:setCharVar("PromathiaStatus", 1)
    end
end

return entity
