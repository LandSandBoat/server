-----------------------------------
-- Area: Windurst Waters
--  NPC: Leepe-Hoppe
-- Involved in Mission 1-3, Mission 7-2
-- !pos 13 -9 -197 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, { 1696, 1697, 1698 }) -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File
        and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TUNING_IN) == QUEST_ACCEPTED
    then
        player:startEvent(886)
    end
end


function onTrigger(player, npc)
    local moonlitPath = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_MOONLIT_PATH)
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
    local MissionStatus = player:getCharVar("MissionStatus")
    local tuningIn = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TUNING_IN)
    local tuningOut = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TUNING_OUT)

    -- Check if we are on Windurst Mission 1-3 and haven't already delivered both offerings.
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_PRICE_OF_PEACE and MissionStatus < 3) then
        if (player:hasKeyItem(tpz.ki.FOOD_OFFERINGS) == false and player:hasKeyItem(tpz.ki.DRINK_OFFERINGS) == false) then
            player:startEvent(140)
        elseif (MissionStatus >= 1) then
            player:startEvent(142) -- Keep displaying the instructions
        end
    -- Check if we are on Windurst Mission 7-2
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(734)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(735)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(739)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 5 and player:hasKeyItem(tpz.ki.BOOK_OF_THE_GODS)) then
        player:startEvent(742)
    ---------------------------
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT) == QUEST_ACCEPTED) then
        player:startEvent(311)

    -- Tuning In
    elseif tuningIn == QUEST_AVAILABLE
        and player:getFameLevel(WINDURST) >= 4
        and (player:getCurrentMission(COP) >= tpz.mission.id.cop.DISTANT_BELIEFS or player:hasCompletedMission(COP, tpz.mission.id.cop.THE_LAST_VERSE))
    then
        player:startEvent(884, 0, 1696, 1697, 1698) -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File


    -- Tuning Out
    elseif tuningIn == QUEST_COMPLETED and tuningOut == QUEST_AVAILABLE then
        player:startEvent(888) -- Starting dialogue

    elseif tuningOut == QUEST_ACCEPTED and player:getCharVar("TuningOut_Progress") == 8 then
        player:startEvent(897) -- Finishing dialogue

    -- The Moonlit Path and Other Fenrir Stuff!
    elseif (moonlitPath == QUEST_AVAILABLE and
        player:getFameLevel(WINDURST) >= 6 and
        player:getFameLevel(SANDORIA) >= 6 and
        player:getFameLevel(BASTOK) >= 6 and
        player:getFameLevel(NORG) >= 4) then -- Fenrir flag event

        player:startEvent(842, 0, 1125)
    elseif (moonlitPath == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.MOON_BAUBLE)) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif (player:hasKeyItem(tpz.ki.WHISPER_OF_THE_MOON)) then -- First turn-in
            local availRewards = 0
            if not player:hasKeyItem(tpz.ki.TRAINERS_WHISTLE) or
                player:hasKeyItem(tpz.ki.FENRIR_WHISTLE) then availRewards = availRewards + 128; end -- Mount Pact

            player:startEvent(846, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif (player:hasKeyItem(tpz.ki.WHISPER_OF_FLAMES) and
            player:hasKeyItem(tpz.ki.WHISPER_OF_TREMORS) and
            player:hasKeyItem(tpz.ki.WHISPER_OF_TIDES) and
            player:hasKeyItem(tpz.ki.WHISPER_OF_GALES) and
            player:hasKeyItem(tpz.ki.WHISPER_OF_FROST) and
            player:hasKeyItem(tpz.ki.WHISPER_OF_STORMS)) then

            -- Collected the whispers
            player:startEvent(844, 0, 1125, 334)
        else -- Talked to after flag without the whispers
            player:startEvent(843, 0, 1125)
        end
    elseif (moonlitPath == QUEST_COMPLETED) then
        if (player:hasKeyItem(tpz.ki.MOON_BAUBLE)) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif (player:hasKeyItem(tpz.ki.WHISPER_OF_THE_MOON)) then -- Repeat turn-in
            local availRewards = 0
            if (player:hasItem(18165)) then availRewards = availRewards + 1; end -- Fenrir's Stone
            if (player:hasItem(13572)) then availRewards = availRewards + 2; end -- Fenrir's Cape
            if (player:hasItem(13138)) then availRewards = availRewards + 4; end -- Fenrir's Torque
            if (player:hasItem(13399)) then availRewards = availRewards + 8; end -- Fenrir's Earring
            if (player:hasItem(1208)) then availRewards = availRewards + 16; end -- Ancient's Key
            if (player:hasSpell(297)) then availRewards = availRewards + 64; end -- Pact
            if not player:hasKeyItem(tpz.ki.TRAINERS_WHISTLE) or
                player:hasKeyItem(tpz.ki.FENRIR_WHISTLE) then availRewards = availRewards + 128; end -- Mount Pact

            player:startEvent(850, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif (realday ~= player:getCharVar("MoonlitPath_date")) then --24 hours have passed, flag a new fight
            player:startEvent(848, 0, 1125, 334)
        end

    elseif tuningIn == QUEST_ACCEPTED then
        player:startEvent(885, 0, 1696, 1697, 1698) -- Reminder to bring Magicked Steel Ingot, Spruce Lumber, Extra-fine File

    elseif tuningOut == QUEST_ACCEPTED then
        player:startEvent(889) -- Reminder to go help Ildy in Kazham

    elseif moonlitPath == QUEST_COMPLETED then
        player:startEvent(847, 0, 1125) -- Having completed Moonlit Path, this will indefinitely replace his standard dialogue!

    else
        player:startEvent(345) -- Standard Dialogue?
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local reward = 0

    if (csid == 140) then
        player:setCharVar("MissionStatus", 1)
        player:setCharVar("ohbiru_dohbiru_talk", 0)
        player:addKeyItem(tpz.ki.FOOD_OFFERINGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FOOD_OFFERINGS)
        player:addKeyItem(tpz.ki.DRINK_OFFERINGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DRINK_OFFERINGS)

    -- Moonlit Path and Other Fenrir Stuff
    elseif (csid == 842 and option == 2) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_MOONLIT_PATH)
    elseif (csid == 844) then
        player:addKeyItem(tpz.ki.MOON_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MOON_BAUBLE)
        player:delKeyItem(tpz.ki.WHISPER_OF_FLAMES)
        player:delKeyItem(tpz.ki.WHISPER_OF_TREMORS)
        player:delKeyItem(tpz.ki.WHISPER_OF_TIDES)
        player:delKeyItem(tpz.ki.WHISPER_OF_GALES)
        player:delKeyItem(tpz.ki.WHISPER_OF_FROST)
        player:delKeyItem(tpz.ki.WHISPER_OF_STORMS)
        player:delQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE)
        player:delQuest(BASTOK, tpz.quest.id.bastok.TRIAL_BY_EARTH)
        player:delQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER)
        player:delQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WIND)
        player:delQuest(SANDORIA, tpz.quest.id.sandoria.TRIAL_BY_ICE)
        player:delQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
    elseif (csid == 846) then -- Turn-in event
        local reward = 0
        if (option == 1) then reward = 18165 -- Fenrir's Stone
        elseif (option == 2) then reward = 13572 -- Fenrir's Cape
        elseif (option == 3) then reward = 13138 -- Fenrir's Torque
        elseif (option == 4) then reward = 13399 -- Fenrir's Earring
        elseif (option == 5) then reward = 1208 -- Ancient's Key
        elseif (option == 6) then
            player:addGil(GIL_RATE*15000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*15000) -- Gil
        elseif (option == 7) then
            player:addSpell(297) -- Pact
        elseif (option == 8) then
            player:addKeyItem(tpz.ki.FENRIR_WHISTLE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FENRIR_WHISTLE)
            -- Pact as Mount
        end

        if (reward ~= nil) then
            player:addTitle(tpz.title.HEIR_OF_THE_NEW_MOON)
            player:delKeyItem(tpz.ki.WHISPER_OF_THE_MOON)
            player:setCharVar("MoonlitPath_date", os.date("%j")) -- %M for next minute, %j for next day
            player:addFame(WINDURST, 30)
            player:completeQuest(WINDURST, tpz.quest.id.windurst.THE_MOONLIT_PATH)
        end

        if (player:getFreeSlotsCount() == 0 and reward ~= 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
        elseif (reward ~= 0) then
            player:addItem(reward)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
        end

        if (player:getNation() == tpz.nation.WINDURST and player:getRank() == 10 and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_PROMISE) == QUEST_COMPLETED) then
            player:addKeyItem(tpz.ki.DARK_MANA_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_MANA_ORB)
        end
    elseif (csid == 850) then -- Repeat turn-in event
        local reward = 0
        if (option == 1) then reward = 18165 -- Fenrir's Stone
        elseif (option == 2) then reward = 13572 -- Fenrir's Cape
        elseif (option == 3) then reward = 13138 -- Fenrir's Torque
        elseif (option == 4) then reward = 13399 -- Fenrir's Earring
        elseif (option == 5) then reward = 1208 -- Ancient's Key
        elseif (option == 6) then
            player:addGil(GIL_RATE*15000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*15000) -- Gil
        elseif (option == 7) then
            player:addSpell(297) -- Pact
        elseif (option == 8) then
            player:addKeyItem(tpz.ki.FENRIR_WHISTLE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FENRIR_WHISTLE)
            -- Pact as Mount
        end

        if (reward ~= nil) then
            player:addTitle(tpz.title.HEIR_OF_THE_NEW_MOON)
            player:delKeyItem(tpz.ki.WHISPER_OF_THE_MOON)
            player:setCharVar("MoonlitPath_date", os.date("%j")) -- %M for next minute, %j for next day
            player:addFame(WINDURST, 30)
        end

        if (player:getFreeSlotsCount() == 0 and reward ~= 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
        elseif (reward ~= 0) then
            player:addItem(reward)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
        end

        if (player:getNation() == tpz.nation.WINDURST and player:getRank() == 10 and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_PROMISE) == QUEST_COMPLETED) then
            player:addKeyItem(tpz.ki.DARK_MANA_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_MANA_ORB)
        end
    elseif (csid == 848) then
        player:addKeyItem(tpz.ki.MOON_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MOON_BAUBLE)
    elseif (csid == 734) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 742) then
        finishMissionTimeline(player, 3, csid, option)

    -- Tuning In
    elseif csid == 884 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.TUNING_IN)

    elseif csid == 886 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.TUNING_IN, {
        gil = 4000,
        title = tpz.title.FINE_TUNER,
    }) then
        player:tradeComplete()

    -- Tuning Out
    elseif csid == 888 then
        player:setCharVar("TuningOut_Progress", 1)
        player:addQuest(WINDURST, tpz.quest.id.windurst.TUNING_OUT)

    elseif csid == 897 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.TUNING_OUT, {
        item = 15180, -- Cache-Nez
        title = tpz.title.FRIEND_OF_THE_HELMED,
    }) then
        player:setCharVar("TuningOut_Progress", 0) -- zero when quest is done
    end
end
