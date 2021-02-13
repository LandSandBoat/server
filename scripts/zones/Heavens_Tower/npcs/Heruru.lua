-----------------------------------
-- Area: Heavens Tower
--  NPC: Heruru
-- Type: Standard NPC
-- !pos 2.321 -26.5 4.641 242
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local missionStatus = player:getCharVar("MissionStatus")

    if
        (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING and missionStatus >= 3) or
        player:hasCompletedMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.MOON_READING)
    then
        player:startEvent(393)
    else
        player:startEvent(62)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 393 then
        player:setCharVar("DizaStar", 0)
    end
end

return entity
