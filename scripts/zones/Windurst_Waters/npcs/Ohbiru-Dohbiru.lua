-----------------------------------
-- Area: Windurst Waters
--  NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
--  Starts and finishes quest: Toraimarai Turmoil
-- !pos 23 -5 -193 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/settings/main")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
    local count = trade:getItemCount()

    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(4351, 1) and count == 1) then
            player:startEvent(355, 900)
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

entity.onTrigger = function(player, npc)
    -- Check for Missions first (priority?)
    -- If the player has started the mission or not
    local pfame = player:getFameLevel(WINDURST)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
    local needToZone = player:needToZone()
    local waterWayToGo = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO)
    local overnightDelivery = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)
    local SayFlowers = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local FlowerProgress = player:getCharVar("FLOWER_PROGRESS")
    local blueRibbonBlues = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)

    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")==2) then
        player:startEvent(872)
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
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

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
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    if (csid == 785 and option == 1) then -- Adds Toraimarai turmoil
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RHINOSTERY_CERTIFICATE)
        player:addKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) -- Rhinostery Certificate
    elseif (csid == 791 and turmoil == QUEST_ACCEPTED) then -- Completes Toraimarai turmoil - first time
        player:addGil(xi.settings.GIL_RATE*4500)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*4500)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
        player:addFame(WINDURST, 100)
        player:addTitle(xi.title.CERTIFIED_RHINOSTERY_VENTURER)
        player:tradeComplete()
    elseif (csid == 791 and turmoil == 2) then -- Completes Toraimarai turmoil - repeats
        player:addGil(xi.settings.GIL_RATE*4500)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*4500)
        player:addFame(WINDURST, 50)
        player:tradeComplete()
    elseif (csid == 352 and option == 0 or csid == 354) then
        if (player:getFreeSlotsCount() >= 1) then
            if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_AVAILABLE) then
                player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO)
            end
            player:addItem(504)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 504)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 504)
        end
    elseif (csid == 355) then
        player:addGil(xi.settings.GIL_RATE*900)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO)
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

return entity
