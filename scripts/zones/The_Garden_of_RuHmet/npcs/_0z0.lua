-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0z0
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    --player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
    --player:setCharVar("PromathiaStatus", 3)

    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar("PromathiaStatus") == 3
    then
        player:startEvent(203)
    elseif
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar("PromathiaStatus") == 5
    then
        player:startEvent(205)
    else
        xi.bcnm.onTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 203 then
        player:setCharVar("PromathiaStatus", 4)
    else
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
