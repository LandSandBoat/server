-----------------------------------
-- Area: Windurst Waters
--  NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
--  Starts and finishes quest: Toraimarai Turmoil
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/common")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Windurst_Waters/IDs")

function onTrade(player, npc, trade)
    local turmoil = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)
    local count = trade:getItemCount()


    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(4351, 1) and count == 1) then
            player:startEvent(355, 900)
        end
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT) == QUEST_ACCEPTED) then
        local OhbiruFood = player:getCharVar("Ohbiru_Food_var")

        if (trade:hasItemQty(4493, 1) == true and trade:hasItemQty(4408, 1) == true and trade:hasItemQty(624, 1) == true and count == 3) then
            if (OhbiruFood < 2) then -- Traded all 3 items & Didn't ask for order
                if (math.random(1, 2) == 1) then
                    player:startEvent(325, 440)
                else
                    player:startEvent(326)
                end
            elseif (OhbiruFood == 2) then -- Traded all 3 items after receiving order
                player:startEvent(322, 440)
            end
        end
    elseif (turmoil == QUEST_ACCEPTED) then
        if (count == 3 and trade:getGil() == 0 and trade:hasItemQty(906, 3) == true) then --Check that all 3 items have been traded
            player:startEvent(791)
        else
            player:startEvent(786, 4500, 267, 906) -- Reminder of needed items
        end
    elseif (turmoil == QUEST_COMPLETED) then
        if (count == 3 and trade:getGil() == 0 and trade:hasItemQty(906, 3) == true) then --Check that all 3 items have been traded
            player:startEvent(791)
        else
            player:startEvent(795, 4500, 0, 906) -- Reminder of needed items for repeated quest
        end
    end
end

function onTrigger(player, npc)
    -- Check for Missions first (priority?)
    -- If the player has started the mission or not
    local pfame = player:getFameLevel(WINDURST)
    local turmoil = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)
    local FoodForThought = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
    local needToZone = player:needToZone()
    local OhbiruFood = player:getCharVar("Ohbiru_Food_var") -- Variable to track progress of Ohbiru-Dohbiru in Food for Thought
    local waterWayToGo = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO)
    local overnightDelivery = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.OVERNIGHT_DELIVERY)
    local SayFlowers = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local FlowerProgress = player:getCharVar("FLOWER_PROGRESS")
    local blueRibbonBlues = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES)

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")==2) then
        player:startEvent(872)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_PRICE_OF_PEACE) then
        if (player:getCharVar("ohbiru_dohbiru_talk") == 1) then
            player:startEvent(143)
        else
            player:startEvent(144)
        end
    elseif ((SayFlowers == QUEST_ACCEPTED or SayFlowers == QUEST_COMPLETED) and FlowerProgress == 1) then
        if (needToZone) then
            player:startEvent(518)
        elseif (player:getCharVar("FLOWER_PROGRESS") == 2) then
            player:startEvent(517, 0, 0, 0, 0, 950)
        else
            player:startEvent(516, 0, 0, 0, 0, 950)
        end
    elseif (waterWayToGo == QUEST_COMPLETED and needToZone) then
        player:startEvent(356, 0, 4351)

    elseif (waterWayToGo == QUEST_ACCEPTED) then
        if (player:hasItem(504) == false and player:hasItem(4351) == false) then
            player:startEvent(354)
        else
            player:startEvent(353)
        end
    elseif (waterWayToGo == QUEST_AVAILABLE and overnightDelivery == QUEST_COMPLETED and pfame >= 3) then
        player:startEvent(352, 0, 4351)

    elseif (FoodForThought == QUEST_AVAILABLE and OhbiruFood == 0) then
        player:startEvent(308) -- Hungry; mentions the experiment. First step in quest for this NPC.
        player:setCharVar("Ohbiru_Food_var", 1)
    elseif (FoodForThought == QUEST_AVAILABLE and OhbiruFood == 1) then
        player:startEvent(309) -- Hungry. The NPC complains of being hungry before the quest is active.
    elseif (FoodForThought == QUEST_ACCEPTED and OhbiruFood < 2) then
        player:startEvent(316, 0, 4493, 624, 4408) -- Gives Order
        player:setCharVar("Ohbiru_Food_var", 2)
    elseif (FoodForThought == QUEST_ACCEPTED and OhbiruFood == 2) then
        player:startEvent(317, 0, 4493, 624, 4408) -- Repeats Order
    elseif (FoodForThought == QUEST_ACCEPTED and OhbiruFood == 3) then
        player:startEvent(324) -- Reminds player to check on friends if he has been given his food.
    elseif (FoodForThought == QUEST_COMPLETED and needToZone == true) then
        player:startEvent(344) -- Post Food for Thought Dialogue
    elseif (overnightDelivery == QUEST_COMPLETED and pfame < 6) then
        player:startEvent(351) -- Post Overnight Delivery Dialogue
    --
    -- Begin Toraimarai Turmoil Section
    --
    elseif blueRibbonBlues == QUEST_COMPLETED and turmoil == QUEST_AVAILABLE and pfame >= 6 and needToZone == false then
        player:startEvent(785, 4500, 267, 906)
    elseif (turmoil == QUEST_ACCEPTED) then
        player:startEvent(786, 4500, 267, 906) -- Reminder of needed items
    elseif (turmoil == QUEST_COMPLETED) then
        player:startEvent(795, 4500, 0, 906) -- Allows player to initiate repeat of Toraimarai Turmoil

    else
        player:startEvent(344)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local tabre =
    {
        [0] = { itemid = 948, gil = 300 }, -- Carnation
        [1] = { itemid = 941, gil = 200 }, -- Red Rose
        [2] = { itemid = 949, gil = 250 }, -- Rain Lily
        [3] = { itemid = 956, gil = 150 }, -- Lilac
        [4] = { itemid = 957, gil = 200 }, -- Amaryllis
        [5] = { itemid = 958, gil = 100 }  -- Marguerite
    }

    -- Check Missions first (priority?)
    local turmoil = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)
    if (csid == 143) then
        player:setCharVar("ohbiru_dohbiru_talk", 2)
    elseif (csid == 322 or csid == 325 or csid == 326) then
        player:tradeComplete()
        player:addGil(GIL_RATE*440)
        if (player:getCharVar("Kerutoto_Food_var") == 2 and player:getCharVar("Kenapa_Food_var") == 4) then -- If this is the last NPC to be fed
            player:completeQuest(WINDURST, tpz.quest.id.windurst.FOOD_FOR_THOUGHT)
            player:addFame(WINDURST, 100)
            player:addTitle(tpz.title.FAST_FOOD_DELIVERER)
            player:needToZone(true)
            player:setCharVar("Kerutoto_Food_var", 0)          -- ------------------------------------------
            player:setCharVar("Kenapa_Food_var", 0)            -- Erase all the variables used in this quest
            player:setCharVar("Ohbiru_Food_var", 0)            -- ------------------------------------------
        else -- If this is NOT the last NPC given food, flag this NPC as completed.
            player:setCharVar("Ohbiru_Food_var", 3)
        end
    elseif (csid == 785 and option == 1) then -- Adds Toraimarai turmoil
        player:addQuest(WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RHINOSTERY_CERTIFICATE)
        player:addKeyItem(tpz.ki.RHINOSTERY_CERTIFICATE) -- Rhinostery Certificate
    elseif (csid == 791 and turmoil == QUEST_ACCEPTED) then -- Completes Toraimarai turmoil - first time
        player:addGil(GIL_RATE*4500)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*4500)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:addFame(WINDURST, 100)
        player:addTitle(tpz.title.CERTIFIED_RHINOSTERY_VENTURER)
        player:tradeComplete()
    elseif (csid == 791 and turmoil == 2) then -- Completes Toraimarai turmoil - repeats
        player:addGil(GIL_RATE*4500)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*4500)
        player:addFame(WINDURST, 50)
        player:tradeComplete()
    elseif (csid == 352 and option == 0 or csid == 354) then
        if (player:getFreeSlotsCount() >= 1) then
            if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_AVAILABLE) then
                player:addQuest(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO)
            end
            player:addItem(504)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 504)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 504)
        end
    elseif (csid == 355) then
        player:addGil(GIL_RATE*900)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.WATER_WAY_TO_GO)
        player:addFame(WINDURST, 40)
        player:tradeComplete()
        player:needToZone(true)
    elseif (csid == 872) then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 3)
    elseif (csid == 516) then
        if (option < 7) then
            local choice = tabre[option]
            if (choice and player:getGil() >= choice.gil) then
                if (player:getFreeSlotsCount() > 0) then
                    player:addItem(choice.itemid)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, choice.itemid)
                    player:delGil(choice.gil)
                    player:needToZone(true)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, choice.itemid)
                end
            else
                player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            end
        elseif (option == 7) then
            player:setCharVar("FLOWER_PROGRESS", 2)
        end
    end
end
