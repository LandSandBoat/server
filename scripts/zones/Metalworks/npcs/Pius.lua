-----------------------------------
-- Area: Metalworks
--  NPC: Pius
-- Involved In Mission: Journey Abroad
-- !pos 99 -21 -12 237
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Mission = player:getCurrentMission(player:getNation())
    local missionStatus = player:getMissionStatus(player:getNation())

    if
        Mission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK and missionStatus == 3
    then
        player:startEvent(355, 1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local pNation = player:getNation()

    if csid == 355 and pNation == xi.nation.WINDURST then -- Only execute for Windurst
        player:setMissionStatus(pNation, 4)
    end
end

return entity
