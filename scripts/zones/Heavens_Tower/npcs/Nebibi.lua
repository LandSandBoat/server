-----------------------------------
-- Area: Heavens Tower
--  NPC: Nebibi
-- Type: Standard NPC
-- !pos 23.539 -27.25 22.589 242
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())

    if
        (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and missionStatus >= 3) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING)
    then
        player:startEvent(399)
    else
        player:startEvent(68)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 399 then
        player:setCharVar("LovelyDay", 0)
    end
end

return entity
