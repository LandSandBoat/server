-----------------------------------
-- Area: Windurst Waters
--  NPC: Kerutoto
-- Starts Quest Food For Thought
-- Involved in Quest: Riding on the Clouds
-- !pos 13 -5 -157 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(12521, 1) and count == 1) then
            player:startEvent(362)
        elseif (trade:hasItemQty(13569, 1) and count == 1) then
            if (player:getCharVar("BlueRibbonBluesProg") == 4) then
                player:startEvent(365) -- Lost, ribbon but it came back
            else
                player:startEvent(358, 3600)
            end
        end

    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT) == QUEST_ACCEPTED) then
        local KerutotoFood = player:getCharVar("Kerutoto_Food_var")
        if (trade:hasItemQty(4371, 1) and count == 1 and KerutotoFood == 1) then
            player:startEvent(332, 440)
        end
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED) then
        if (player:getCharVar("ridingOnTheClouds_4") == 3 and trade:hasItemQty(1127, 1) and count == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_4", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SPIRITED_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPIRITED_STONE)
        end
    end

end

function onTrigger(player, npc)
    local KerutotoFood = player:getCharVar("Kerutoto_Food_var") -- Variable to track progress of Kerutoto in Food for Thought
    local FoodForThought = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
    local OhbiruFood = player:getCharVar("Ohbiru_Food_var") -- Variable to track progress of Ohbiru-Dohbiru in Food for Thought
    local BlueRibbonBlues = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES)
    local needZone = player:needToZone()
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
    local waking_dreams = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WAKING_DREAMS)

    -- Awakening of the Gods --
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(737)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(736)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(738)

    -- Three Paths --
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 3) then
        player:startEvent(876)

    -- Waking Dreams --
    elseif (player:hasKeyItem(tpz.ki.VIAL_OF_DREAM_INCENSE)==false and ((player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) and  waking_dreams == QUEST_AVAILABLE ) or(waking_dreams  == QUEST_COMPLETED and realday ~= player:getCharVar("Darkness_Named_date")))) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.WAKING_DREAMS)
        player:startEvent(918)--918

    elseif (player:hasKeyItem(tpz.ki.WHISPER_OF_DREAMS) == true) then
        local availRewards = 0
        if (player:hasItem(17599)) then availRewards = availRewards + 1; end -- Diabolos's Pole
        if (player:hasItem(14814)) then availRewards = availRewards + 2; end -- Diabolos's Earring
        if (player:hasItem(15557)) then availRewards = availRewards + 4; end -- Diabolos's Ring
        if (player:hasItem(15516)) then availRewards = availRewards + 8; end -- Diabolos's Torque
        if (player:hasSpell(304)) then availRewards = availRewards + 32 -- Pact
        else availRewards = availRewards + 16 -- Gil
        end
        player:startEvent(920, 17599, 14814, 15557, 15516, 0, 0, 0, availRewards)

    -- Blue Ribbon Blues --
    elseif (BlueRibbonBlues == QUEST_COMPLETED and needZone) then
        player:startEvent(363)--363
    elseif (BlueRibbonBlues == QUEST_ACCEPTED) then
        local blueRibbonProg = player:getCharVar("BlueRibbonBluesProg")
        if (player:hasItem(12521)) then
            player:startEvent(362)--362
        elseif (blueRibbonProg == 2 and needZone == false) then
            local timerDay = player:getCharVar("BlueRibbonBluesTimer_Day")
            local currentDay = VanadielDayOfTheYear()

            if (player:getCharVar("BlueRibbonBluesTimer_Year") < VanadielYear()) then
                player:startEvent(360) --  go to the grave  360
            elseif (timerDay + 1 == VanadielDayOfTheYear() and player:getCharVar("BlueRibbonBluesTimer_Hour") <= VanadielHour()) then
                player:startEvent(360) --  go to the grave  360
            elseif (timerDay + 2 <=  VanadielDayOfTheYear()) then
                player:startEvent(360) --  go to the grave  360
            else
                player:startEvent(359) -- Thanks for the ribbon 359
            end

        elseif (blueRibbonProg == 3) then
            if (player:hasItem(13569)) then
                player:startEvent(361, 0, 13569) -- remidner, go to the grave
            else
                player:startEvent(366, 0, 13569) -- lost the ribbon
            end
        elseif (blueRibbonProg == 4) then
            player:startEvent(366, 0, 13569)
        else
            player:startEvent(306) -- Standard Conversation
        end
    elseif (BlueRibbonBlues == QUEST_AVAILABLE and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_COMPLETED and player:getFameLevel(WINDURST) >= 5) then
        player:startEvent(357)

    -- Food for Thought --
    elseif (FoodForThought == QUEST_AVAILABLE) then
        if (OhbiruFood == 1 and KerutotoFood ~= 256) then -- Player knows the researchers are hungry and quest not refused
            player:startEvent(313, 0, 4371) -- Offered Quest 1 (Including Order ifYES)
        elseif (OhbiruFood == 1 and KerutotoFood == 256) then -- Player knows the researchers are hungry and quest refused previously
            player:startEvent(314, 0, 4371) -- Offered Quest 2 (Including Order ifYES)
        else
            player:startEvent(312) -- Before Quest: Asks you to check on others.
        end
    elseif (FoodForThought == QUEST_ACCEPTED) then
        if (KerutotoFood == 1)  then
            player:startEvent(315, 0, 4371) -- Repeats Order
        elseif (KerutotoFood == 2) then
            player:startEvent(333) -- Reminder to check with the others if this NPC has already been fed
        end
    elseif (FoodForThought == QUEST_COMPLETED and needZone) then
        player:startEvent(304) -- NPC is sleeping but feels full (post Food for Thought)

    else
        player:startEvent(306) -- Standard Conversation
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 876) then
        player:setCharVar("COP_Ulmia_s_Path", 4)
    elseif ((csid == 313 and option == 0) or (csid == 314 and option == 0)) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
        player:setCharVar("Kerutoto_Food_var", 1)
    elseif (csid == 313 and option == 1) then
        player:setCharVar("Kerutoto_Food_var", 256)
    elseif (csid == 332) then
        player:tradeComplete()
        player:addGil(GIL_RATE*440)
        if (player:getCharVar("Kenapa_Food_var") == 4 and player:getCharVar("Ohbiru_Food_var") == 3) then -- If this is the last NPC to be fed
            player:completeQuest(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
            player:addFame(WINDURST, 100)
            player:addTitle(tpz.title.FAST_FOOD_DELIVERER)
            player:needToZone(true)
            player:setCharVar("Kerutoto_Food_var", 0)        -- ------------------------------------------
            player:setCharVar("Kenapa_Food_var", 0)            -- Erase all the variables used in this quest
            player:setCharVar("Ohbiru_Food_var", 0)            -- ------------------------------------------
        else -- If this is NOT the last NPC given food, flag this NPC as completed.
            player:setCharVar("Kerutoto_Food_var", 2)
        end
    elseif (csid == 357) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES)
    elseif (csid == 358 or csid == 365) then
        player:tradeComplete()
        player:setCharVar("BlueRibbonBluesProg", 2)
        player:setCharVar("BlueRibbonBluesTimer_Hour", VanadielHour())
        player:setCharVar("BlueRibbonBluesTimer_Year", VanadielYear())
        player:setCharVar("BlueRibbonBluesTimer_Day", VanadielDayOfTheYear())
        player:needToZone(true)
        if (csid == 358) then
            player:addGil(GIL_RATE*3600)
        end
    elseif (csid == 360) then
        if (player:getFreeSlotsCount() >= 1) then
            player:setCharVar("BlueRibbonBluesProg", 3)
            player:setCharVar("BlueRibbonBluesTimer_Hour", 0)
            player:setCharVar("BlueRibbonBluesTimer_Year", 0)
            player:setCharVar("BlueRibbonBluesTimer_Day", 0)
            player:addItem(13569)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13569)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13569)
        end
    elseif (csid == 362) then
        player:completeQuest(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES)
        player:setCharVar("BlueRibbonBluesProg", 0)
        player:addFame(WINDURST, 140)
        player:addTitle(tpz.title.GHOSTIE_BUSTER)
        player:needToZone(true)
    elseif (csid == 918) then    --diablos start
        player:addKeyItem(tpz.ki.VIAL_OF_DREAM_INCENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VIAL_OF_DREAM_INCENSE)
    elseif (csid == 920) then    --diablos reward
        local item = 0
        local addspell = 0
        if (option == 1 and player:hasItem(17599)==false) then item = 17599--diaboloss-pole

        elseif (option == 2 and player:hasItem(14814)==false) then item = 14814--diaboloss-earring

        elseif (option == 3 and player:hasItem(15557)==false) then item = 15557--diaboloss-ring

        elseif (option == 4 and player:hasItem(15516)==false) then item = 15516--diaboloss-torque


        elseif (option == 5) then
            player:addGil(GIL_RATE*15000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*15000) -- Gil
            player:delKeyItem(tpz.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", os.date("%j")) -- %M for next minute, %j for next day
            player:completeQuest(WINDURST, tpz.quest.id.windurst.WAKING_DREAMS)

        elseif (option == 6 and player:hasSpell(304)==false) then
            player:addSpell(304) -- diabolos Spell
            player:messageSpecial(ID.text.DIABOLOS_UNLOCKED, 0, 0, 0)
            addspell=1
        end
        if (addspell==1) then
            player:delKeyItem(tpz.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", os.date("%j")) -- %M for next minute, %j for next day
            player:completeQuest(WINDURST, tpz.quest.id.windurst.WAKING_DREAMS)
        elseif (item > 0 and player:getFreeSlotsCount()~=0) then
            player:delKeyItem(tpz.ki.WHISPER_OF_DREAMS)
            player:setCharVar("Darkness_Named_date", os.date("%j")) -- %M for next minute, %j for next day
            player:completeQuest(WINDURST, tpz.quest.id.windurst.WAKING_DREAMS)
            player:addItem(item)
            player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
        elseif ( option ~= 5 and  (( item == 0 and  addspell==0 ) or (item > 0 and player:getFreeSlotsCount() == 0) ) ) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        end
    elseif (csid == 736) then
        player:setCharVar("MissionStatus", 2)

    end

end
