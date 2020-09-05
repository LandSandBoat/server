-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Helaku
-- Involved in Missions 2-3
-- !pos 49 -2 -12 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentMission = player:getCurrentMission(BASTOK)
    local missionStatus = player:getCharVar("MissionStatus")

    if (currentMission == tpz.mission.id.bastok.THE_EMISSARY) then
        -- Bastok Mission 2-3 Part I - San d'Oria > Windurst
        if (missionStatus == 1) then
            player:startEvent(676)
        elseif (missionStatus == 2) then
            player:startEvent(536)
        elseif (missionStatus == 3) then
            player:showText(npc, ID.text.HELAKU_DIALOG)
        -- Bastok Mission 2-3 Part II - Windurst > San d'Oria
        elseif (missionStatus == 7) then
            player:startEvent(537)
        elseif (missionStatus == 11) then
            player:startEvent(557)
        end
    -- Bastok Mission 2-3 Part I - San d'Oria > Windurst
    elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_SANDORIA) then
        if (missionStatus <= 4) then
            player:startEvent(542)
        else
            player:startEvent(543)
        end
    -- Bastok Mission 2-3 Part II - Windurst > San d'Oria
    elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_SANDORIA2) then
        missionStatus = player:getCharVar("MissionStatus")
        if (missionStatus == 7) then
            player:startEvent(537)
        elseif (missionStatus == 9) then
            player:startEvent(542)
        elseif (player:hasKeyItem(tpz.ki.KINDRED_CREST)) then
            player:startEvent(545)
        end
    else
        player:startEvent(541)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 536) then
        player:setCharVar("MissionStatus", 3)
    elseif (csid == 543) then
        player:addMission(BASTOK, tpz.mission.id.bastok.THE_EMISSARY)
        player:setCharVar("MissionStatus", 6)
    elseif (csid == 537 and option == 0) then
        player:addMission(BASTOK, tpz.mission.id.bastok.THE_EMISSARY_SANDORIA2)
        player:setCharVar("MissionStatus", 8)
    elseif (csid == 545) then
        player:addMission(BASTOK, tpz.mission.id.bastok.THE_EMISSARY)
        player:setCharVar("MissionStatus", 11)
        player:addKeyItem(tpz.ki.KINDRED_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.KINDRED_REPORT)
        player:delKeyItem(tpz.ki.KINDRED_CREST)
    end
end
