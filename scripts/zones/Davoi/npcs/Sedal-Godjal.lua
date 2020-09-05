-----------------------------------
-- Area: Davoi
--  NPC: Sedal-Godjal
-- Mini Quest used in : Whence Blows the Wind
-- !pos 185 -3 -116 149
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")

function onTrade(player, npc, trade)

    local CurrentMission = player:getCurrentMission(WINDURST)
    local MissionStatus = player:getCharVar("MissionStatus")

    if (trade:hasItemQty(17437, 1)) then
        if (CurrentMission == tpz.mission.id.windurst.VAIN and MissionStatus == 3 and player:hasKeyItem(tpz.ki.MAGIC_DRAINED_STAR_SEEKER) == true) then
            player:startEvent(120)
        end
    end
end

function onTrigger(player, npc)

    local CurrentMission = player:getCurrentMission(WINDURST)
    local MissionStatus = player:getCharVar("MissionStatus")

    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(122, 0, 276)
    elseif (CurrentMission == tpz.mission.id.windurst.VAIN and MissionStatus >= 2) then -- wiki says it doesnt matter whether you get cs or kill first
        if (player:hasKeyItem(tpz.ki.STAR_SEEKER) == true) then
            player:startEvent(118, 0, 17437, tpz.ki.STAR_SEEKER)
        elseif (player:hasKeyItem(tpz.ki.MAGIC_DRAINED_STAR_SEEKER) and MissionStatus == 4) then
            player:startEvent(121)
        else
            player:startEvent(119, 0, 17437)
        end

    elseif (player:hasKeyItem(tpz.ki.CRIMSON_ORB) == false) then

        local miniQuestForORB_CS = player:getCharVar("miniQuestForORB_CS")
        local countRedPoolForORB = player:getCharVar("countRedPoolForORB")

        if (miniQuestForORB_CS == 0) then
            player:startEvent(24); --
        elseif (miniQuestForORB_CS == 99) then
            player:startEvent(22) -- Start mini quest
        elseif (miniQuestForORB_CS == 1 and countRedPoolForORB ~= 15) then
            player:startEvent(21) -- During mini quest
        elseif (miniQuestForORB_CS == 1 and countRedPoolForORB == 15) then
            player:startEvent(25, 0, 0, 0, tpz.ki.CRIMSON_ORB) -- Finish mini quest
        end
    else
        player:startEvent(24) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 22 and option == 1) then
        player:setCharVar("miniQuestForORB_CS", 1)
        player:addKeyItem(tpz.ki.WHITE_ORB)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WHITE_ORB)
    elseif (csid == 25) then
        player:setCharVar("miniQuestForORB_CS", 0)
        player:setCharVar("countRedPoolForORB", 0)
        player:delKeyItem(tpz.ki.CURSED_ORB)
        player:addKeyItem(tpz.ki.CRIMSON_ORB)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CRIMSON_ORB)
    elseif (csid == 118) then
        player:delKeyItem(tpz.ki.STAR_SEEKER)
        player:addKeyItem(tpz.ki.MAGIC_DRAINED_STAR_SEEKER)
        player:setCharVar("MissionStatus", 3)
    elseif (csid == 120) then
        player:tradeComplete()
        player:setCharVar("MissionStatus", 4)
    elseif (csid == 122) then
        player:addKeyItem(tpz.ki.AURASTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AURASTERY_RING)
        if (player:hasKeyItem(tpz.ki.OPTISTERY_RING) and player:hasKeyItem(tpz.ki.RHINOSTERY_RING)) then
            player:setCharVar("MissionStatus", 2)
        end
    end

end
