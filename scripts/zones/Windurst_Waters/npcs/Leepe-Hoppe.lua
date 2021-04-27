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
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, { 1696, 1697, 1698 }) -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File
        and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TUNING_IN) == QUEST_ACCEPTED
    then
        player:startEvent(886)
    end
end


entity.onTrigger = function(player, npc)
    local moonlitPath = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
    local missionStatus = player:getMissionStatus(player:getNation())
    local tuningIn = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TUNING_IN)
    local tuningOut = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TUNING_OUT)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    -- Check if we are on Windurst Mission 1-3 and haven't already delivered both offerings.
    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_PRICE_OF_PEACE and missionStatus < 3) then
        if (player:hasKeyItem(xi.ki.FOOD_OFFERINGS) == false and player:hasKeyItem(xi.ki.DRINK_OFFERINGS) == false) then
            player:startEvent(140)
        elseif (missionStatus >= 1) then
            player:startEvent(142) -- Keep displaying the instructions
        end
    -- Check if we are on Windurst Mission 7-2
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(734)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 1) then
        player:startEvent(735)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(739)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 5 and player:hasKeyItem(xi.ki.BOOK_OF_THE_GODS)) then
        player:startEvent(742)
    -----------------------------------
    elseif (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT) == QUEST_ACCEPTED) then
        player:startEvent(311)

    -- Tuning In
    elseif tuningIn == QUEST_AVAILABLE
        and player:getFameLevel(WINDURST) >= 4
        and (player:getCurrentMission(COP) >= xi.mission.id.cop.DISTANT_BELIEFS or player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE))
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
        if (player:hasKeyItem(xi.ki.MOON_BAUBLE)) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif (player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON)) then -- First turn-in
            local availRewards = 0
            if not player:hasKeyItem(xi.ki.TRAINERS_WHISTLE) or
                player:hasKeyItem(xi.ki.FENRIR_WHISTLE) then availRewards = availRewards + 128; end -- Mount Pact

            player:startEvent(846, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif (player:hasKeyItem(xi.ki.WHISPER_OF_FLAMES) and
            player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS) and
            player:hasKeyItem(xi.ki.WHISPER_OF_TIDES) and
            player:hasKeyItem(xi.ki.WHISPER_OF_GALES) and
            player:hasKeyItem(xi.ki.WHISPER_OF_FROST) and
            player:hasKeyItem(xi.ki.WHISPER_OF_STORMS)) then

            -- Collected the whispers
            player:startEvent(844, 0, 1125, 334)
        else -- Talked to after flag without the whispers
            player:startEvent(843, 0, 1125)
        end
    elseif (moonlitPath == QUEST_COMPLETED) then
        if (player:hasKeyItem(xi.ki.MOON_BAUBLE)) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif (player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON)) then -- Repeat turn-in
            local availRewards = 0
            if (player:hasItem(18165)) then availRewards = availRewards + 1; end -- Fenrir's Stone
            if (player:hasItem(13572)) then availRewards = availRewards + 2; end -- Fenrir's Cape
            if (player:hasItem(13138)) then availRewards = availRewards + 4; end -- Fenrir's Torque
            if (player:hasItem(13399)) then availRewards = availRewards + 8; end -- Fenrir's Earring
            if (player:hasItem(1208)) then availRewards = availRewards + 16; end -- Ancient's Key
            if (player:hasSpell(297)) then availRewards = availRewards + 64; end -- Pact
            if not player:hasKeyItem(xi.ki.TRAINERS_WHISTLE) or
                player:hasKeyItem(xi.ki.FENRIR_WHISTLE) then availRewards = availRewards + 128; end -- Mount Pact

            player:startEvent(850, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif (os.time() > player:getCharVar("MoonlitPath_date")) then --24 hours have passed, flag a new fight
            player:startEvent(848, 0, 1125, 334)
        end
    elseif tuningIn == QUEST_ACCEPTED then
        player:startEvent(885, 0, 1696, 1697, 1698) -- Reminder to bring Magicked Steel Ingot, Spruce Lumber, Extra-fine File
    elseif tuningOut == QUEST_ACCEPTED then
        player:startEvent(889) -- Reminder to go help Ildy in Kazham
    elseif moonlitPath == QUEST_COMPLETED then
        player:startEvent(847, 0, 1125) -- Having completed Moonlit Path, this will indefinitely replace his standard dialogue!
    elseif turmoil == QUEST_ACCEPTED then
        player:startEvent(790, 0, xi.ki.RHINOSTERY_CERTIFICATE)
    else
        player:startEvent(345) -- Standard Dialogue?
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local reward = 0

    if (csid == 140) then
        player:setMissionStatus(player:getNation(), 1)
        player:setCharVar("ohbiru_dohbiru_talk", 0)
        player:addKeyItem(xi.ki.FOOD_OFFERINGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FOOD_OFFERINGS)
        player:addKeyItem(xi.ki.DRINK_OFFERINGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DRINK_OFFERINGS)

    -- Moonlit Path and Other Fenrir Stuff
    elseif (csid == 842 and option == 2) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
    elseif (csid == 844) then
        player:addKeyItem(xi.ki.MOON_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOON_BAUBLE)
        player:delKeyItem(xi.ki.WHISPER_OF_FLAMES)
        player:delKeyItem(xi.ki.WHISPER_OF_TREMORS)
        player:delKeyItem(xi.ki.WHISPER_OF_TIDES)
        player:delKeyItem(xi.ki.WHISPER_OF_GALES)
        player:delKeyItem(xi.ki.WHISPER_OF_FROST)
        player:delKeyItem(xi.ki.WHISPER_OF_STORMS)
        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
        player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
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
            player:addKeyItem(xi.ki.FENRIR_WHISTLE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FENRIR_WHISTLE)
            -- Pact as Mount
        end

        if (reward ~= nil) then
            player:addTitle(xi.title.HEIR_OF_THE_NEW_MOON)
            player:delKeyItem(xi.ki.WHISPER_OF_THE_MOON)
            player:setCharVar("MoonlitPath_date", getMidnight())
            player:addFame(WINDURST, 30)
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
        end

        if (player:getFreeSlotsCount() == 0 and reward ~= 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
        elseif (reward ~= 0) then
            player:addItem(reward)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
        end

        if (player:getNation() == xi.nation.WINDURST and player:getRank() == 10 and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE) == QUEST_COMPLETED) then
            player:addKeyItem(xi.ki.DARK_MANA_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DARK_MANA_ORB)
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
            player:addKeyItem(xi.ki.FENRIR_WHISTLE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FENRIR_WHISTLE)
            -- Pact as Mount
        end

        if (reward ~= nil) then
            player:addTitle(xi.title.HEIR_OF_THE_NEW_MOON)
            player:delKeyItem(xi.ki.WHISPER_OF_THE_MOON)
            player:setCharVar("MoonlitPath_date", getMidnight())
            player:addFame(WINDURST, 30)
        end

        if (player:getFreeSlotsCount() == 0 and reward ~= 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
        elseif (reward ~= 0) then
            player:addItem(reward)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
        end

        if (player:getNation() == xi.nation.WINDURST and player:getRank() == 10 and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE) == QUEST_COMPLETED) then
            player:addKeyItem(xi.ki.DARK_MANA_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DARK_MANA_ORB)
        end
    elseif (csid == 848) then
        player:addKeyItem(xi.ki.MOON_BAUBLE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOON_BAUBLE)
    elseif (csid == 734) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 742) then
        finishMissionTimeline(player, 3, csid, option)

    -- Tuning In
    elseif csid == 884 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TUNING_IN)

    elseif csid == 886 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.TUNING_IN, {
        gil = 4000,
        title = xi.title.FINE_TUNER,
    }) then
        player:tradeComplete()

    -- Tuning Out
    elseif csid == 888 then
        player:setCharVar("TuningOut_Progress", 1)
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TUNING_OUT)

    elseif csid == 897 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.TUNING_OUT, {
        item = 15180, -- Cache-Nez
        title = xi.title.FRIEND_OF_THE_HELMED,
    }) then
        player:setCharVar("TuningOut_Progress", 0) -- zero when quest is done
    end
end

return entity
