-----------------------------------
-- Area: Davoi
--  NPC: Sedal-Godjal
-- Involved in Quests: Whence the Wind Blows
-- Involved in Missions: Windurst 8-1/8-2
-- !pos 185 -3 -116 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
    -- Vain (Windurst 8-1)
    if
        npcUtil.tradeHas(trade, 17437) and -- Curse Wand
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and
        player:getCharVar("MissionStatus") == 3 and
        player:hasKeyItem(tpz.ki.MAGIC_DRAINED_STAR_SEEKER)
    then
        player:startEvent(120)
    end
end

function onTrigger(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getCharVar("MissionStatus")

    -- The Jester Who'd Be King (Windurst 8-2)
    if 
        currentMission == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getCharVar("MissionStatus") == 1 and not
        player:hasKeyItem(tpz.ki.AURASTERY_RING)
    then
        player:startEvent(122, 0, tpz.ki.AURASTERY_RING)

    -- Vain (Windurst 8-1)
    elseif currentMission == tpz.mission.id.windurst.VAIN and missionStatus >= 2 then -- wiki says it doesnt matter whether you get cs or kill first
        if player:hasKeyItem(tpz.ki.STAR_SEEKER) == true then
            player:startEvent(118, 0, 17437, tpz.ki.STAR_SEEKER)
        elseif player:hasKeyItem(tpz.ki.MAGIC_DRAINED_STAR_SEEKER) and missionStatus == 4 then
            player:startEvent(121)
        else
            player:startEvent(119, 0, 17437)
        end

    -- Whence Blows the Wind
    elseif player:hasKeyItem(tpz.ki.CRIMSON_ORB) == false then
        local miniQuestForORB_CS = player:getCharVar("miniQuestForORB_CS")

        if miniQuestForORB_CS == 0 then
            player:startEvent(24)
        elseif miniQuestForORB_CS == 99 then
            player:startEvent(22) -- Start mini quest
        elseif miniQuestForORB_CS == 1 and player:getCharVar("countRedPoolForORB") ~= 15 then
            player:startEvent(21) -- During mini quest
        elseif miniQuestForORB_CS == 1 then
            player:startEvent(25, 0, 0, 0, tpz.ki.CRIMSON_ORB) -- Finish mini quest
        end

    -- Standard dialog
    else
        player:startEvent(24)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- The Jester Who'd Be King (Windurst 8-2)
    if csid == 122 and npcUtil.giveKeyItem(player, tpz.ki.AURASTERY_RING) then
        if player:hasKeyItem(tpz.ki.RHINOSTERY_RING) and player:hasKeyItem(tpz.ki.OPTISTERY_RING) then
            player:setCharVar("MissionStatus", 2)
        end

    -- Vain (Windurst 8-1)
    elseif csid == 118 then
        player:delKeyItem(tpz.ki.STAR_SEEKER)
        npcUtil.giveKeyItem(player, tpz.ki.MAGIC_DRAINED_STAR_SEEKER)
        player:setCharVar("MissionStatus", 3)
    elseif csid == 120 then
        player:tradeComplete()
        player:setCharVar("MissionStatus", 4)

    -- Whence Blows the Wind
    elseif csid == 22 and option == 1 then
        player:setCharVar("miniQuestForORB_CS", 1)
        npcUtil.giveKeyItem(player, tpz.ki.WHITE_ORB)
    elseif csid == 25 then
        player:setCharVar("miniQuestForORB_CS", 0)
        player:setCharVar("countRedPoolForORB", 0)
        player:delKeyItem(tpz.ki.CURSED_ORB)
        npcUtil.giveKeyItem(player, tpz.ki.CRIMSON_ORB)
    end
end
