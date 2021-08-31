-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Kasaroro
-- Type: Consulate Representative
-- Involved in Mission: 2-3 Windurst
-- !pos -72 -3 34 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local pNation = player:getNation()
    if (pNation == xi.nation.WINDURST) then
        local currentMission = player:getCurrentMission(pNation)
        local missionStatus = player:getMissionStatus(player:getNation())

        if (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS) then
            if (missionStatus == 2) then
                player:startEvent(546)
            elseif (missionStatus == 6) then
                player:showText(npc, ID.text.KASARORO_DIALOG + 7)
            elseif (missionStatus == 7) then
                player:startEvent(547)
            elseif (missionStatus == 11) then
                player:showText(npc, ID.text.KASARORO_DIALOG + 20)
            end
        elseif (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA) then
            if (missionStatus == 3) then
                player:showText(npc, ID.text.KASARORO_DIALOG)
            elseif (missionStatus == 4) then
                player:startEvent(549)
            elseif (missionStatus == 5) then
                player:startEvent(550) -- done with Sandy first path, now go to bastok
            end
        elseif (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2) then
            if (missionStatus == 8) then
                player:showText(npc, ID.text.KASARORO_DIALOG)
            elseif (missionStatus == 10) then
                player:startEvent(551)
            end
        elseif (player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)) then
            player:startEvent(604)
        else
            player:startEvent(548)
        end
    else
        player:startEvent(548)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 546) then
        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA)
        player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
        player:setMissionStatus(player:getNation(), 3)
    elseif (csid == 550) then
        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
        player:setMissionStatus(player:getNation(), 6)
    elseif (csid == 547) then
        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2)
        player:setMissionStatus(player:getNation(), 8)
    elseif (csid == 551) then
        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
        player:delKeyItem(xi.ki.KINDRED_CREST)
        player:addKeyItem(xi.ki.KINDRED_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.KINDRED_REPORT)
        player:setMissionStatus(player:getNation(), 11)
    end

end

return entity
