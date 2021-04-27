-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nelcabrit
-- Involved in Mission: San d'Oria 3-3, 4-1
-- !pos -32 9 -49 243
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
        local currentMission = player:getCurrentMission(pNation)
        local missionStatus = player:getMissionStatus(player:getNation())

        if currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and missionStatus == 3 then
            player:startEvent(42)
        elseif currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and missionStatus == 4 then
            player:startEvent(67)
        elseif currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and missionStatus == 5 then
            player:startEvent(140)
        elseif player:getRank() == 4 and missionStatus == 0 then
            if getMissionRankPoints(player, 13) == 1 then
                player:startEvent(45)
            else
                player:startEvent(49)
            end
        elseif currentMission == xi.mission.id.sandoria.MAGICITE and missionStatus == 1 then
            player:startEvent(133)
        elseif currentMission == xi.mission.id.sandoria.MAGICITE and missionStatus <= 5 then
            player:startEvent(136)
        elseif currentMission == xi.mission.id.sandoria.MAGICITE and missionStatus == 6 then
            player:startEvent(36)
        elseif player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_SANDORIA) then
            player:startEvent(56)
        else
            player:startEvent(102)
        end
    elseif pNation == xi.nation.WINDURST then
        player:startEvent(47)
    elseif pNation == xi.nation.BASTOK then
        player:startEvent(46)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 42 then
        player:setMissionStatus(player:getNation(), 4)
        player:delKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 140 then
        player:setMissionStatus(player:getNation(), 6)
    elseif csid == 36 then
        finishMissionTimeline(player, 3, csid, option)
    end
end

return entity
