-----------------------------------
-- Area: Port Windurst
--  NPC: Gold Skull
-- Mission NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(BASTOK) ~= tpz.mission.id.bastok.NONE) then
        currentMission = player:getCurrentMission(BASTOK)
        missionStatus = player:getCharVar("MissionStatus")

        if (player:hasKeyItem(tpz.ki.SWORD_OFFERING)) then
            player:startEvent(53)
        elseif (player:hasKeyItem(tpz.ki.KINDRED_REPORT)) then
            player:startEvent(68)
        elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_WINDURST2) then
            if (missionStatus == 7) then
                player:startEvent(62)
            elseif (missionStatus == 8) then
                player:showText(npc, ID.text.GOLD_SKULL_DIALOG + 27)
            elseif (missionStatus == 9) then
                player:startEvent(57)
            end
        elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_WINDURST) then
            if (missionStatus == 2) then
                player:startEvent(50)
            elseif (missionStatus == 12) then
                player:startEvent(54)
            elseif (missionStatus == 14) then
                player:showText(npc, ID.text.GOLD_SKULL_DIALOG)
            elseif (missionStatus == 15) then
                player:startEvent(57)
            end
        else
            player:startEvent(43)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 53) then
        player:addKeyItem(tpz.ki.DULL_SWORD)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DULL_SWORD)
        player:delKeyItem(tpz.ki.SWORD_OFFERING)
    end

end
