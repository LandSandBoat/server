-----------------------------------
-- Area: Windurst Waters
--  NPC: Baren-Moren
-- Starts and Finishes Quest: Hat in Hand
-- !pos -66 -3 -148 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    featherstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP)
    if (featherstatus >= 1 and trade:hasItemQty(842, 3) == true and trade:getGil() == 0 and trade:getItemCount() == 3) then
        player:startEvent(79, 1500) -- Quest Turn In
    end
end

function onTrigger(player, npc)

--    player:delQuest(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP)  -- ================== FOR TESTING ONLY =====================
--    player:addFame(WINDURST, 200)   -- ================== FOR TESTING ONLY =====================

    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end
    hatstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    featherstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP)
    pfame = player:getFameLevel(WINDURST)
    if (hatstatus == 0) then
        player:startEvent(48) -- Quest Offered
--    elseif ((hatstatus == 1 or player:getCharVar("QuestHatInHand_var2") == 1) and player:getCharVar("QuestHatInHand_count") == 0) then
--        player:startEvent(51, 80) -- Hat in Hand: During Quest - Objective Reminder
    elseif (hatstatus == 1 or player:getCharVar("QuestHatInHand_var2") == 1) then
        --     Variable to track quest progress
        --     1 = Machitata       !pos 163 0 -22
        --    2 = Honoi-Gomoi       !pos -195 -11 -120
        --    4 = Kenapa-Keppa    !pos 27 -6 -199
        --    8 = Clais            !pos -31 -3 11
        --    16 = Kyume-Romeh    !pos -58 -4 23
        --  32 = Tosuka-Porika    !pos -26 -6 103
        --  64 = Pechiru-Mashiru !pos 162 -2 159
        --  128 = Bondada        !pos -66 -3 -148
        count = player:getCharVar("QuestHatInHand_count")
        if (count == 8) then                 -- 80 = HAT + FULL REWARD  =  8 NPCS - Option 5
            player:startEvent(52, 80)
        elseif (count >= 6) then            -- 50 = HAT + GOOD REWARD  >= 6-7 NPCS - Option 4
            player:startEvent(52, 50)
        elseif (count >= 4) then            -- 30 = PARTIAL REWARD -   >= 4-5 NPCS - Option 3
            player:startEvent(52, 30)
        elseif (count >= 2) then            -- 20 = POOR REWARD         >= 2-3 NPCS - Option 2
            player:startEvent(52, 20)
        else                                -- 0/nill = NO REWARD         >= 0-1 NPCS - Option 1
            player:startEvent(52)
        end
    elseif (featherstatus == 1 or player:getCharVar("QuestFeatherInOnesCap_var") == 1) then
        player:startEvent(78, 0, 842) -- Quest Objective Reminder
    elseif (hatstatus == 2 and featherstatus == 0 and pfame >= 3 and player:needToZone() == false and player:getCharVar("QuestHatInHand_var2") == 0) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(75, 0, 842) -- Quest "Feather In One's Cap" offered
        else
            player:startEvent(49) -- Repeatable Quest "Hat In Hand" offered
        end

    elseif     (featherstatus == 2 and player:needToZone() == false) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(49) -- Repeatable Quest "Hat In Hand" offered
        else
            player:startEvent(75, 0, 842) -- Repeatable Quest "A Feather In One's Cap" offered
        end
    elseif (player:needToZone() == false) then
        player:startEvent(49) -- Repeatable Quest "Hat In Hand" offered
    else   --  Will run through these if fame is not high enough for other quests
        rand = math.random(1, 6)
        if (rand == 1) then
            player:startEvent(42) -- Standard Conversation 1
        elseif (rand == 2) then
            player:startEvent(44) -- Standard Conversation 2
        elseif (rand == 3) then
            player:startEvent(45) -- Standard Conversation 3
        elseif (rand == 4) then
            player:startEvent(46) -- Standard Conversation 4
        elseif (rand == 5) then
            player:startEvent(47) -- Standard Conversation 5
        elseif (rand == 6) then
            player:startEvent(1022) -- Standard Conversation 6
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
printf("RESULT: %u", option)
    if (csid == 48 and option == 1) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
        player:addKeyItem(tpz.ki.NEW_MODEL_HAT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.NEW_MODEL_HAT)
    elseif (csid == 49 and option == 1) then
        player:setCharVar("QuestHatInHand_var2", 1)
        player:addKeyItem(tpz.ki.NEW_MODEL_HAT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.NEW_MODEL_HAT)
    elseif (csid == 52 and option >= 4 and player:getFreeSlotsCount(0) == 0) then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12543)
    elseif (csid == 52 and option >= 1) then
        if (option == 5) then          --    80 = HAT + FULL REWARD  =  8 NPCS - Option 5
            player:addGil(GIL_RATE*500)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*500)
            if (player:hasItem(12543) == false) then
                player:addItem(12543, 1)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 12543)
            end
        elseif (option == 4) then     -- 50 = HAT + GOOD REWARD  >= 6 NPCS - Option 4
            player:addGil(GIL_RATE*400)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*400)
            if (player:hasItem(12543) == false) then
                player:addItem(12543, 1)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 12543)
            end
        elseif (option == 3) then     -- 30 = PARTIAL REWARD -   >= 4 NPCS - Option 3
            player:addGil(GIL_RATE*300)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*300)
        elseif (option == 2) then     -- 20 = POOR REWARD         >= 2 NPCS - Option 2
            player:addGil(GIL_RATE*150)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*150)
--        else (option == 1) then     -- 0/nill = NO REWARD      >= 0 NPCS - Option 1
        end
        if (hatstatus == 1) then
            player:addFame(WINDURST, 75)
        else
            player:addFame(WINDURST, 8)
        end
        player:completeQuest(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
        player:setCharVar("QuestHatInHand_count", 0)
        player:setCharVar("QuestHatInHand_var", 0)
        player:needToZone(true)
        player:delKeyItem(tpz.ki.NEW_MODEL_HAT)
        player:setCharVar("QuestHatInHand_var2", 0)


    elseif (csid == 75 and option == 1) then
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP) == QUEST_AVAILABLE) then
            player:addQuest(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP)
        elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP) == QUEST_COMPLETED) then
            player:setCharVar("QuestFeatherInOnesCap_var", 1)
        end
    elseif (csid == 79) then
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP) == QUEST_ACCEPTED) then
            player:completeQuest(WINDURST, tpz.quest.id.windurst.A_FEATHER_IN_ONE_S_CAP)
            player:addFame(WINDURST, 75)
        else
            player:addFame(WINDURST, 8)
            player:setCharVar("QuestFeatherInOnesCap_var", 0)
        end
        player:addGil(GIL_RATE*1500)
        player:tradeComplete(trade)
        player:needToZone(true)
    end
end
