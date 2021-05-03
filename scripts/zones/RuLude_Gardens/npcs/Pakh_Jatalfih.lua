-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Pakh Jatalfih
-- Involved in Mission: Windurst 3-3, 4-1
-- !pos 34 8 -35 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.WINDURST then
        local currentMission = player:getCurrentMission(pNation)
        local missionStatus = player:getMissionStatus(player:getNation())

        if currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and missionStatus == 1 then
            player:startEvent(43)
        elseif currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and missionStatus == 2 then
            player:startEvent(68)
        elseif currentMission == xi.mission.id.windurst.A_NEW_JOURNEY and missionStatus == 3 then
            player:startEvent(141)
        elseif player:getRank() == 4 and missionStatus == 0 then
            if getMissionRankPoints(player, 13) == 1 then
                player:startEvent(50)
            else
                player:startEvent(54)
            end
        elseif currentMission == xi.mission.id.windurst.MAGICITE and missionStatus == 1 then
            player:startEvent(134)
        elseif currentMission == xi.mission.id.windurst.MAGICITE and missionStatus <= 5 then
            player:startEvent(137)
        elseif currentMission == xi.mission.id.windurst.MAGICITE and missionStatus == 6 then
            player:startEvent(37)
        elseif player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_WINDURST) then
            player:startEvent(57)
        else
            player:startEvent(103)
        end
    elseif pNation == xi.nation.SANDORIA then
        player:startEvent(52)
    elseif pNation == xi.nation.BASTOK then
        player:startEvent(51)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 43 then
        player:setMissionStatus(player:getNation(), 2)
        player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 141 then
        player:setMissionStatus(player:getNation(), 4)
    elseif csid == 37 then
        finishMissionTimeline(player, 1, csid, option)
    end
end

return entity
