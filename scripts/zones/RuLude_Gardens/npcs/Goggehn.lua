-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Goggehn
-- Involved in Mission: Bastok 3-3, 4-1
-- !pos 3 9 -76 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.BASTOK then
        local currentMission = player:getCurrentMission(pNation)
        local missionStatus = player:getMissionStatus(player:getNation())

        if currentMission == xi.mission.id.bastok.JEUNO and missionStatus == 1 then
            player:startEvent(41)
        elseif currentMission == xi.mission.id.bastok.JEUNO and missionStatus == 2 then
            player:startEvent(66)
        elseif currentMission == xi.mission.id.bastok.JEUNO and missionStatus == 3 then
            player:startEvent(139)
        elseif player:getRank() == 4 and missionStatus == 0 then
            if getMissionRankPoints(player, 13) == 1 then
                player:startEvent(3)
            else
                player:startEvent(4)
            end
        elseif currentMission == xi.mission.id.bastok.MAGICITE and missionStatus == 1 then
            player:startEvent(132)
        elseif currentMission == xi.mission.id.bastok.MAGICITE and missionStatus <= 5 then
            player:startEvent(135)
        elseif currentMission == xi.mission.id.bastok.MAGICITE and missionStatus == 6 then
            player:startEvent(35)
        elseif player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK) then
            player:startEvent(55)
        else
            player:startEvent(101)
        end
    elseif pNation == xi.nation.SANDORIA then
        player:startEvent(1)
    elseif pNation == xi.nation.WINDURST then
        player:startEvent(2)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 41 then
        player:setMissionStatus(player:getNation(), 2)
        player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 139 then
        player:setMissionStatus(player:getNation(), 4)
    elseif csid == 35 then
        finishMissionTimeline(player, 1, csid, option)
    end
end

return entity
