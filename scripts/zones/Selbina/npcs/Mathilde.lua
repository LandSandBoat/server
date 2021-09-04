-----------------------------------
-- Area: Selbina
--  NPC: Mathilde
-- Involved in Quest: Riding on the Clouds
-- !pos 12.578 -8.287 -7.576 248
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS and player:getCharVar("PromathiaStatus") == 2 then
        player:startEvent(10005)
    else
        player:startEvent(171)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10005 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)
    end
end

return entity
