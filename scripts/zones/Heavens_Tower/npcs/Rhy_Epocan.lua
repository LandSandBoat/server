-----------------------------------
-- Area: Heavens Tower
--  NPC: Rhy Epocan
-- Involved in Mission 3-1
-- !pos 2 -48 14 242
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())

    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and
        (missionStatus >= 3 or player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING))
    then
        player:startEvent(405)
    else
        player:startEvent(93)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 405 then
        player:setCharVar("MilitaryStrength", 0)
    end
end

return entity
