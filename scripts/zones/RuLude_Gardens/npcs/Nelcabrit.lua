-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nelcabrit
-- Involved in Mission: San d'Oria 3-3, 4-1
-- !pos -32 9 -49 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pNation = player:getNation()

    if pNation == tpz.nation.SANDORIA then
        local currentMission = player:getCurrentMission(pNation)
        local MissionStatus = player:getCharVar("MissionStatus")

        if currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 3 then
            player:startEvent(42)
        elseif currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 4 then
            player:startEvent(67)
        elseif currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 5 then
            player:startEvent(140)
        elseif player:getRank() == 4 and MissionStatus == 0 then
            if getMissionRankPoints(player, 13) == 1 then
                player:startEvent(45)
            else
                player:startEvent(49)
            end
        elseif currentMission == tpz.mission.id.sandoria.MAGICITE and MissionStatus == 1 then
            player:startEvent(133)
        elseif currentMission == tpz.mission.id.sandoria.MAGICITE and MissionStatus <= 5 then
            player:startEvent(136)
        elseif currentMission == tpz.mission.id.sandoria.MAGICITE and MissionStatus == 6 then
            player:startEvent(36)
        elseif player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_SANDORIA) then
            player:startEvent(56)
        else
            player:startEvent(102)
        end
    elseif pNation == tpz.nation.WINDURST then
        player:startEvent(47)
    elseif pNation == tpz.nation.BASTOK then
        player:startEvent(46)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 42 then
        player:setCharVar("MissionStatus", 4)
        player:delKeyItem(tpz.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 140 then
        player:setCharVar("MissionStatus", 6)
    elseif csid == 36 then
        finishMissionTimeline(player, 3, csid, option)
    end
end
