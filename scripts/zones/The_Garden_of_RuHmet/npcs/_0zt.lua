-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: Luminus convergence
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar("PromathiaStatus") == 5
    then
        player:startEvent(204)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 204 then
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        player:setCharVar("PromathiaStatus", 0)
    end
end

return entity
