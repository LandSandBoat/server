-----------------------------------
-- Area: Lower Jeuno
--  NPC: Faursel
-- Type: Aht Urhgan Quest NPC
-- Involved in Quests: The Road to Aht Urhgan
-- !pos 37.985 3.118 -45.208 245
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local questStatus = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)
    local questStatusVar = player:getCharVar("THE_ROAD_TO_AHT_URHGAN")

    if (questStatus == QUEST_ACCEPTED and questStatusVar == 1) then

        if (trade:hasItemQty(537, 1) == true and trade:hasItemQty(538, 1) == true and trade:hasItemQty(539, 1) == true
        and trade:hasItemQty(540, 1) == true and trade:hasItemQty(541, 1) == true and trade:hasItemQty(542, 1) == true and trade:getItemCount() == 6 and trade:getGil() == 0) then -- Beginner List (Subjob Items)
            player:startEvent(10070)
        elseif (trade:hasItemQty(1532, 1) and trade:hasItemQty(1533, 1) and trade:hasItemQty(1535, 1) and trade:getItemCount() == 3 and trade:getGil() == 0) then -- Intermediate List
            player:startEvent(10070)
        elseif (trade:hasItemQty(1692, 1) and trade:hasItemQty(1693, 1) and trade:hasItemQty(1694, 1) and trade:getItemCount() == 3 and trade:getGil() == 0) then -- Advanced List (Chips)
            player:startEvent(10070)
        elseif (trade:hasItemQty(1042, 1) or trade:hasItemQty(1043, 1) or trade:hasItemQty(1044, 1) or trade:hasItemQty(1049, 1) or trade:hasItemQty(1050, 1) or
            trade:hasItemQty(1054, 1) or trade:hasItemQty(1059, 1) and trade:getItemCount() == 1 and trade:getGil() == 0) then -- Advanced List (Coffer Keys)
                player:startEvent(10070)
        elseif (trade:hasItemQty(1426, 1) or trade:hasItemQty(1427, 1) or trade:hasItemQty(1428, 1) or trade:hasItemQty(1429, 1) or trade:hasItemQty(1430, 1) or
            trade:hasItemQty(1431, 1) or trade:hasItemQty(1432, 1) or trade:hasItemQty(1433, 1) or trade:hasItemQty(1434, 1) or trade:hasItemQty(1435, 1) or
            trade:hasItemQty(1436, 1) or trade:hasItemQty(1437, 1) or trade:hasItemQty(1438, 1) or trade:hasItemQty(1439, 1) or trade:hasItemQty(1440, 1) or
            trade:hasItemQty(2331, 1) or trade:hasItemQty(2332, 1) or trade:hasItemQty(2333, 1) or trade:hasItemQty(2556, 1) or trade:hasItemQty(2557, 1) and trade:getItemCount() == 1 and trade:getGil() == 0) then -- Advanced List (Testimonys)
                player:startEvent(10070)
        end
    end
end

function onTrigger(player, npc)

    local passDay = player:getCharVar("THE_ROAD_TO_AHT_URHGAN_Day")
    local passYear = player:getCharVar("THE_ROAD_TO_AHT_URHGAN_Year")
    local currentDay = VanadielDayOfTheYear()
    local passReady = ((passDay < currentDay) or (passDay > currentDay and passYear < VanadielYear()))
    local questStatus = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)
    local questStatusVar = player:getCharVar("THE_ROAD_TO_AHT_URHGAN")

    if (questStatus == QUEST_AVAILABLE and ENABLE_TOAU == 1) then
        player:startEvent(10062) -- Offer Quest, First Dialog.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 0) then
        player:startEvent(10063) -- Offically offer quest, Second Dialog.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 1) then
        player:startEvent(10064) -- Player did not make a decision during Second Dialog. Offering the list again.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 2 and passReady ~= true) then
        player:startEvent(10066) -- Bought Bording Pass, Player must wait One Day.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 3 and passReady ~= true) then
        player:startEvent(10072) -- Quested for Bording Pass, Player must wait One Day.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 2 and passReady == true) then
        player:startEvent(10067) -- Bought Bording Pass, ready to issue.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 3 and passReady == true) then
        player:startEvent(10070) -- Quested for Bording Pass, ready to issue.
    elseif (questStatus == QUEST_ACCEPTED and questStatusVar == 4) then
        player:startEvent(10068) -- Bought Bording Pass, returned from the Woodlands.
    elseif (questStatus == QUEST_COMPLETED) then
        player:startEvent(10071) -- Regular chat dialog after the quest.
    else
        player:startEvent(10065) -- Regular chat dialog.
    end

end

function onEventUpdate(player, csid, option)

    if (csid == 10063 or csid == 10064) then
        if (option == 10) then     -- Beginner List
            player:updateEvent(537, 538, 539, 540, 541, 542, 0, 0)
        elseif (option == 12) then -- Intermediate List
            player:updateEvent(1532, 1533, 1535, 0, 0, 0, 0, 0)
        elseif (option == 13) then -- Advanced List
            player:updateEvent(1692, 1693, 1694, 0, 0, 0, 0, 0)
        elseif (option == 14) then -- Gil Option
            player:updateEvent(1, 1, 1, 1, 1, 1, player:getGil(), 1)
        elseif (option == 2 or option == 1073741824) then  -- Let me think about it... / Cancel

        end
    end

end

function onEventFinish(player, csid, option)

    if (csid == 10062 and option == 1) then -- Offer Quest, First Dialog.
        player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)
    elseif (csid == 10063 or csid == 10064) then
        if (csid == 10063 and option == 1 or csid == 10063 and option == 2) then -- Offically offer quest, Second Dialog.
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN", 1)
        elseif (option == 3) then
            player:delGil(500000)
            player:setCharVar("THE_ROAD_TO_AHT_URHGAN", 2)
            player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Day", VanadielDayOfTheYear())
            player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Year", VanadielYear())
        end
    elseif (csid == 10067) then
        player:addKeyItem(tpz.ki.MAP_OF_WAJAOM_WOODLANDS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAP_OF_WAJAOM_WOODLANDS)
        player:addKeyItem(tpz.ki.BOARDING_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOARDING_PERMIT)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN", 4)
        tpz.teleport.to(player, tpz.teleport.id.WAJAOM_LEYPOINT)
    elseif (csid == 10068) then
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN", 0)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Day", 0)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Year", 0)
        player:addFame(JEUNO, 30)
    elseif (csid == 10070) then
        player:addKeyItem(tpz.ki.BOARDING_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOARDING_PERMIT)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN", 0)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Day", 0)
        player:setCharVar("THE_ROAD_TO_AHT_URHGAN_Year", 0)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
    end
end
