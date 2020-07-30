-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Goggehn
-- Involved in Mission: Bastok 3-3, 4-1
-- !pos 3 9 -76 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pNation = player:getNation()

    if pNation == tpz.nation.BASTOK then
        local currentMission = player:getCurrentMission(pNation)
        local MissionStatus = player:getCharVar("MissionStatus")

        if currentMission == tpz.mission.id.bastok.JEUNO and MissionStatus == 1 then
            player:startEvent(41)
        elseif currentMission == tpz.mission.id.bastok.JEUNO and MissionStatus == 2 then
            player:startEvent(66)
        elseif currentMission == tpz.mission.id.bastok.JEUNO and MissionStatus == 3 then
            player:startEvent(139)
        elseif player:getRank() == 4 and MissionStatus == 0 then
            if getMissionRankPoints(player, 13) == 1 then
                player:startEvent(3)
            else
                player:startEvent(4)
            end
        elseif currentMission == tpz.mission.id.bastok.MAGICITE and MissionStatus == 1 then
            player:startEvent(132)
        elseif currentMission == tpz.mission.id.bastok.MAGICITE and MissionStatus <= 5 then
            player:startEvent(135)
        elseif currentMission == tpz.mission.id.bastok.MAGICITE and MissionStatus == 6 then
            player:startEvent(35)
        elseif player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_BASTOK) then
            player:startEvent(55)
        else
            player:startEvent(101)
        end
    elseif pNation == tpz.nation.SANDORIA then
        player:startEvent(1)
    elseif pNation == tpz.nation.WINDURST then
        player:startEvent(2)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 41 then
        player:setCharVar("MissionStatus", 2)
        player:delKeyItem(tpz.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 139 then
        player:setCharVar("MissionStatus", 4)
    elseif csid == 35 then
        finishMissionTimeline(player, 1, csid, option)
    end
end
