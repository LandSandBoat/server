-----------------------------------
-- Area: Windurst Waters
--  NPC: Chamama
-- Involved In Quest: Inspector's Gadget
-- Starts Quest: In a Pickle
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local FakeMoustache = player:hasKeyItem(tpz.ki.FAKE_MOUSTACHE)
    local InvisibleManSticker = player:hasKeyItem(tpz.ki.INVISIBLE_MAN_STICKER)
    local InAPickle = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.IN_A_PICKLE)
    local count = trade:getItemCount()
    local gil = trade:getGil()

    if ((InAPickle == QUEST_ACCEPTED or InAPickle == QUEST_COMPLETED) and trade:hasItemQty(583, 1) == true and count == 1 and gil == 0) then
        local rand = math.random(1, 4)
        if (rand <= 2) then
            if (InAPickle == QUEST_ACCEPTED) then
                player:startEvent(659) -- IN A PICKLE: Quest Turn In (1st Time)
            elseif (InAPickle == QUEST_COMPLETED) then
                player:startEvent(662, 200)
            end
        elseif (rand == 3) then
            player:startEvent(657)  -- IN A PICKLE: Too Light
            player:tradeComplete(trade)
        elseif (rand == 4) then
            player:startEvent(658)  -- IN A PICKLE: Too Small
            player:tradeComplete(trade)
        end
    elseif (FakeMoustache == false) then
        local InspectorsGadget = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.INSPECTOR_S_GADGET)

        if (InspectorsGadget == QUEST_ACCEPTED) then
            local SarutaCotton = trade:hasItemQty(834, 4)

            if (SarutaCotton == true and count == 4) then
                player:startEvent(552)
            end
        end
    elseif (InvisibleManSticker == false) then
        local ThePromise = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_PROMISE)

        if (ThePromise == QUEST_ACCEPTED) then
            local ShoalWeed = trade:hasItemQty(1148, 1)

            if (ShoalWeed == true and count == 1) then
                player:startEvent(799, 0, 0, tpz.ki.INVISIBLE_MAN_STICKER)
            end
        end
    end

end

function onTrigger(player, npc)
    local InspectorsGadget = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.INSPECTOR_S_GADGET)
    local ThePromise = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_PROMISE)
    local InAPickle = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.IN_A_PICKLE)
    local NeedToZone = player:needToZone()

    if (ThePromise == QUEST_ACCEPTED) then
        local InvisibleManSticker = player:hasKeyItem(tpz.ki.INVISIBLE_MAN_STICKER)

        if (InvisibleManSticker == true) then
            player:startEvent(800)
        else
            local ThePromiseVar = player:getCharVar("ThePromise")

            if (ThePromiseVar == 1) then
                player:startEvent(798, 0, 1148, tpz.ki.INVISIBLE_MAN_STICKER)
            else
                player:startEvent(797, 0, 1148, tpz.ki.INVISIBLE_MAN_STICKER)
            end
        end
    elseif (InspectorsGadget == QUEST_ACCEPTED) then
        local FakeMoustache = player:hasKeyItem(tpz.ki.FAKE_MOUSTACHE)
        -- printf("mustach check")
        if (FakeMoustache == true) then
            player:startEvent(553)
        else
            player:startEvent(551, 0, tpz.ki.FAKE_MOUSTACHE)
        end
    elseif (InAPickle == QUEST_AVAILABLE and NeedToZone == false) then
        local rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(654, 0, 4444) -- IN A PICKLE + RARAB TAIL: Quest Begin
        else
            player:startEvent(651) -- Standard Conversation
        end
    elseif (InAPickle == QUEST_ACCEPTED or player:getCharVar("QuestInAPickle_var") == 1) then
        player:startEvent(655, 0, 4444) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
    elseif (InAPickle == QUEST_COMPLETED and NeedToZone) then
        player:startEvent(660) -- IN A PICKLE: After Quest
    elseif (InAPickle == QUEST_COMPLETED and NeedToZone == false and player:getCharVar("QuestInAPickle_var") ~= 1) then
        local rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(661) -- IN A PICKLE: Repeatable Quest Begin
        else
            player:startEvent(651) -- Standard Conversation
        end
    else
        player:startEvent(651) -- Standard Conversation
    end
-- player:delQuest(WINDURST, tpz.quest.id.windurst.IN_A_PICKLE); [[[[[[[[[[[[[ FOR TESTING ONLY ]]]]]]]]]]]]]
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 552) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.FAKE_MOUSTACHE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FAKE_MOUSTACHE)
    elseif (csid == 797) then
        player:setCharVar("ThePromise", 1)
    elseif (csid == 799) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.INVISIBLE_MAN_STICKER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.INVISIBLE_MAN_STICKER)
    elseif (csid == 654 and option == 1) then  -- IN A PICKLE + RARAB TAIL: Quest Begin
        player:addQuest(WINDURST, tpz.quest.id.windurst.IN_A_PICKLE)
    elseif (csid == 659) then  -- IN A PICKLE: Quest Turn In (1st Time)
        player:tradeComplete(trade)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.IN_A_PICKLE)
        player:needToZone(true)
        player:addItem(12505)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 12505)
        player:addGil(GIL_RATE*200)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*200)
        player:addFame(WINDURST, 75)
    elseif (csid == 661 and option == 1) then
        player:setCharVar("QuestInAPickle_var", 1)
    elseif (csid == 662) then  -- IN A PICKLE + 200 GIL: Repeatable Quest Turn In
        player:tradeComplete(trade)
        player:needToZone(true)
        player:addGil(GIL_RATE*200)
        player:addFame(WINDURST, 8)
        player:setCharVar("QuestInAPickle_var", 0)
    end
end
