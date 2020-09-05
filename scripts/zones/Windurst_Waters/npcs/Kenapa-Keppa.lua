-----------------------------------
-- Area: Windurst Waters
--  NPC: Kenapa Keppa
-- Involved in Quest: Food For Thought, Hat in Hand
-- !pos 27 -6 -199 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local FoodForThought = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
    local KenapaFood = player:getCharVar("Kenapa_Food_var") -- Variable to track progress of Kenapa-Keppa in Food for Thought

    if (FoodForThought == QUEST_ACCEPTED) then
        count = trade:getItemCount()
        gil = trade:getGil()
        if (trade:hasItemQty(4409, 1) == false) then -- Traded in wrong item. Not accepted.
            player:startEvent(329)
        elseif (count == 1 and trade:hasItemQty(4409, 1) == true and gil == 0) then
            if (KenapaFood < 3) then -- Traded item without receiving order
                if (math.random(1, 2) == 1) then
                    player:startEvent(331)
                else
                    player:startEvent(330, 120)
                end
            elseif (KenapaFood == 3) then  -- Traded item after receiving order
                player:startEvent(327, 120)
            end
        end
    end
end

function onTrigger(player, npc)

    local OvernightDelivery = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
    local FoodForThought = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
    local SayFlowers = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local FlowerProgress = player:getCharVar("FLOWER_PROGRESS") -- Variable to track progress of Say It with Flowers.
    local hatstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    local KenapaFood = player:getCharVar("Kenapa_Food_var") -- Variable to track progress of Kenapa-Keppa in Food for Thought
    local KenapaOvernight = player:getCharVar("Kenapa_Overnight_var") -- Variable to track progress for Overnight Delivery
    local KenapaOvernightDay = player:getCharVar("Kenapa_Overnight_Day_var") -- Variable to track the day the quest is started.
    local KenapaOvernightHour = player:getCharVar("Kenapa_Overnight_Hour_var") -- Variable to track the hour the quest is started.
    local needToZone = player:needToZone()
    local pFame = player:getFameLevel(WINDURST)
    local HourOfTheDay = VanadielHour()

    if ((hatstatus == 1 or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 4) == false) then
        player:startEvent(56) -- Show Off Hat
    elseif ((SayFlowers == QUEST_ACCEPTED or SayFlowers == QUEST_COMPLETED) and FlowerProgress == 2) then
        player:startEvent(519)
    elseif (FoodForThought == QUEST_AVAILABLE) then
        player:startEvent(310) -- Hungry script
    elseif (FoodForThought == QUEST_ACCEPTED) then
        if (KenapaFood == 0) then
            player:startEvent(318) -- Stammer 1/3
            player:setCharVar("Kenapa_Food_var", 1)
        elseif (KenapaFood == 1) then
            player:startEvent(319) -- Stammer 2/3
            player:setCharVar("Kenapa_Food_var", 2)
        elseif (KenapaFood == 2) then
            player:startEvent(320, 0, 4409) -- Gives Order
            player:setCharVar("Kenapa_Food_var", 3)
        elseif (FoodForThought == QUEST_ACCEPTED and KenapaFood == 3) then
            rand = math.random(1, 3)
            if (rand == 1) then
                player:startEvent(320, 0, 4409) -- Repeats Order
            elseif (rand == 2) then
                player:startEvent(321) -- "Or Whatever"
            else
                player:startEvent(328) -- "..<Grin>.."
            end
        elseif (FoodForThought == QUEST_ACCEPTED and KenapaFood == 4) then -- Give standard conversation options if this NPC has been fed but others haven't
            rand = math.random(1, 2)
            if (rand == 1) then
                player:startEvent(302) -- Standard converstation
            else
                player:startEvent(303) -- Standard converstation
            end
        end
    elseif (FoodForThought == QUEST_COMPLETED and OvernightDelivery == QUEST_AVAILABLE and needToZone == false and (HourOfTheDay >= 7 and HourOfTheDay < 24) and pFame >= 1 and KenapaOvernight ~= 256) then
        if (KenapaOvernight == 0) then
            player:startEvent(336)
        elseif (KenapaOvernight == 1) then
            player:startEvent(337)
        elseif (KenapaOvernight == 2) then
            player:startEvent(338)
        elseif (KenapaOvernight == 3) then
            player:startEvent(339) -- Actual quest acceptance Dialogue
        end
    elseif (FoodForThought == QUEST_COMPLETED and OvernightDelivery == QUEST_AVAILABLE and KenapaOvernight == 256) then
        if (HourOfTheDay > 6 and HourOfTheDay < 7) then
            player:startEvent(347) -- Failed to return in time; dialogue before quest can be repeated
        else
            player:startEvent(336) -- Restart the quest from the beginning
        end
    elseif (OvernightDelivery == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SMALL_BAG) == false) then
        if (KenapaOvernight == 4) then
            player:startEvent(340) -- Reminder for Overnight Delivery #1
        elseif (KenapaOvernight == 5) then
            player:startEvent(341) -- Reminder for Overnight Delivery #2
        elseif (KenapaOvernight == 6) then
            player:startEvent(342) -- Reminder for Overnight Delivery #3
        elseif (KenapaOvernight == 7) then
            player:startEvent(343) -- Reminder for Overnight Delivery #4
        end
    elseif (OvernightDelivery == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SMALL_BAG) == true and (HourOfTheDay <= 6 or HourOfTheDay >= 18)) then
        if (VanadielDayOfTheYear() == KenapaOvernightDay and (KenapaOvernightHour <= 24 or KenapaOvernightHour < 6)) then
            player:startEvent(348) -- Brought the key item back inside the time frame; got the item and returned it on the same day
        elseif (VanadielDayOfTheYear() == KenapaOvernightDay + 1 and KenapaOvernightHour <= 24) then
            player:startEvent(348) -- Brought the key item back inside the time frame
        else
            player:startEvent(346) -- Failed to return in time
        end
    elseif (OvernightDelivery == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SMALL_BAG) == true and HourOfTheDay > 6) then
        player:startEvent(346) -- Failed to return in time
    elseif (OvernightDelivery == QUEST_COMPLETED) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(349) -- Random comment after Overnight Delivery #1
        else
            player:startEvent(350) -- Random comment after Overnight Delivery #2
        end
    else
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(302) -- Standard converstation
        else
            player:startEvent(303) -- Standard converstation
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 327 or csid == 330 or csid == 331) then
        player:tradeComplete()
        player:addGil(GIL_RATE*120)
        if (player:getCharVar("Kerutoto_Food_var") == 2 and player:getCharVar("Ohbiru_Food_var") == 3) then -- If this is the last NPC to be fed
            player:completeQuest(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
            player:addTitle(tpz.title.FAST_FOOD_DELIVERER)
            player:addFame(WINDURST, 100)
            player:needToZone(true)
            player:setCharVar("Kerutoto_Food_var", 0)          -- ------------------------------------------
            player:setCharVar("Kenapa_Food_var", 0)            -- Erase all the variables used in this quest
            player:setCharVar("Ohbiru_Food_var", 0)            -- ------------------------------------------
        else -- If this is NOT the last NPC given food, flag this NPC as completed.
            player:setCharVar("Kenapa_Food_var", 4)
        end
    elseif  (csid == 56) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 4)
        player:addCharVar("QuestHatInHand_count", 1)
    elseif (csid == 336) then
        player:setCharVar("Kenapa_Overnight_var", 1)
    elseif (csid == 337) then
        player:setCharVar("Kenapa_Overnight_var", 2)
    elseif (csid == 338) then
        player:setCharVar("Kenapa_Overnight_var", 3)
    elseif (csid == 339) then
        if (option == 0) then
            player:addQuest(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
            player:setCharVar("Kenapa_Overnight_var", 4)
        else
            player:setCharVar("Kenapa_Overnight_var", 0)
        end
    elseif (csid == 340) then
        player:setCharVar("Kenapa_Overnight_var", 5)
    elseif (csid == 341) then
        player:setCharVar("Kenapa_Overnight_var", 6)
    elseif (csid == 342) then
        player:setCharVar("Kenapa_Overnight_var", 7)
    elseif (csid == 343) then
        player:setCharVar("Kenapa_Overnight_var", 4) -- Begin reminder sequence
    elseif (csid == 346) then
        player:delQuest(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
        player:delKeyItem(tpz.ki.SMALL_BAG)
        player:setCharVar("Kenapa_Overnight_Hour_var", 0)
        player:setCharVar("Kenapa_Overnight_var", 256)
    elseif (csid == 348) then
        if (player:getFreeSlotsCount() > 0) then
            player:addItem(12590)
            player:delKeyItem(tpz.ki.SMALL_BAG)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12590)
            player:completeQuest(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
            player:addFame(WINDURST, 100)
            player:needToZone(true)
            player:setCharVar("Kenapa_Overnight_var", 0)
            player:setCharVar("Kenapa_Overnight_Hour_var", 0)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12590)
        end
    elseif (csid == 519) then
        player:setCharVar("FLOWER_PROGRESS", 3)
    end
end
