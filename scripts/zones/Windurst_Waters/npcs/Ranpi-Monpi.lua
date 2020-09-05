-----------------------------------
-- Area: Windurst Waters
--  NPC: Ranpi-Monpi
-- Starts and Finishes Quest: A Crisis in the Making
-- Involved in quest: In a Stew, For Want of a Pot, The Dawn of Delectability
-- !pos -116 -3 52  238
-- (outside the shop he is in)
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)

    IASvar = player:getCharVar("IASvar")

    -- In a Stew
    if (IASvar == 3) then
        count = trade:getItemCount()
        if (trade:hasItemQty(4373, 3) and count == 3) then
            player:startEvent(556) -- Correct items given, advance quest
        else
            player:startEvent(555, 0, 4373) -- incorrect or not enough, play reminder dialog
        end

    end

end

function onTrigger(player, npc)
    crisisstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
    IAS = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.IN_A_STEW)
    IASvar = player:getCharVar("IASvar")

    -- In a Stew
    if (IAS == QUEST_ACCEPTED and IASvar == 2) then
        player:startEvent(554, 0, 4373)                    -- start fetch portion of quest
    elseif (IAS == QUEST_ACCEPTED and IASvar == 3) then
        player:startEvent(555, 0, 4373)                    -- reminder dialog
    elseif (IAS == QUEST_ACCEPTED and IASvar == 4) then
        player:startEvent(557)                             -- new dialog before finish of quest

    -- A Crisis in the Making
    elseif (crisisstatus == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2 and player:needToZone() == false) then -- A Crisis in the Making + ITEM: Quest Offer
        player:startEvent(258, 0, 625)
    elseif (crisisstatus == QUEST_ACCEPTED) then
        prog = player:getCharVar("QuestCrisisMaking_var")
        if (prog == 1) then -- A Crisis in the Making: Quest Objective Reminder
            player:startEvent(262, 0, 625)
        elseif (prog == 2) then -- A Crisis in the Making: Quest Finish
            player:startEvent(267)
        end
    elseif (crisisstatus == QUEST_COMPLETED and player:needToZone() == false and player:getCharVar("QuestCrisisMaking_var") == 0) then  -- A Crisis in the Making + ITEM: Repeatable Quest Offer
        player:startEvent(259, 0, 625)
    elseif (crisisstatus == QUEST_COMPLETED and player:getCharVar("QuestCrisisMaking_var") == 1) then  -- A Crisis in the Making: Quest Objective Reminder
        player:startEvent(262, 0, 625)
    elseif (crisisstatus == QUEST_COMPLETED and player:getCharVar("QuestCrisisMaking_var") == 2) then -- A Crisis in the Making: Repeatable Quest Finish
        player:startEvent(268)
    else
    --Standard dialogs
        rand = math.random(1, 3)
        if (rand == 1) then  -- STANDARD CONVO: sings song about ingredients
            player:startEvent(249)
        elseif (rand == 2) then   -- STANDARD CONVO 2: sings song about ingredients
            player:startEvent(251)
        elseif (rand == 3) then   -- STANDARD CONVO 3:
            player:startEvent(256)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- A Crisis in the Making
    if (csid == 258 and option == 1) then  -- A Crisis in the Making + ITEM: Quest Offer - ACCEPTED
        player:addQuest(WINDURST, tpz.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
        player:setCharVar("QuestCrisisMaking_var", 1)
        player:needToZone(true)
    elseif (csid == 258 and option == 2) then  -- A Crisis in the Making + ITEM: Quest Offer - REFUSED
        player:needToZone(true)
    elseif (csid == 259 and option == 1) then  -- A Crisis in the Making + ITEM: Repeatable Quest Offer - ACCEPTED
        player:setCharVar("QuestCrisisMaking_var", 1)
        player:needToZone(true)
    elseif (csid == 259 and option == 2) then  -- A Crisis in the Making + ITEM: Repeatable Quest Offer - REFUSED
        player:needToZone(true)
    elseif (csid == 267) then -- A Crisis in the Making: Quest Finish
        player:addGil(GIL_RATE*400)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*400)
        player:setCharVar("QuestCrisisMaking_var", 0)
        player:delKeyItem(tpz.ki.OFF_OFFERING)
        player:addFame(WINDURST, 75)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
        player:needToZone(true)
    elseif (csid == 268) then -- A Crisis in the Making: Repeatable Quest Finish
        player:addGil(GIL_RATE*400)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*400)
        player:setCharVar("QuestCrisisMaking_var", 0)
        player:delKeyItem(tpz.ki.OFF_OFFERING)
        player:addFame(WINDURST, 8)
        player:needToZone(true)

    -- In a Stew
    elseif (csid == 554) then        -- start fetch portion
        player:setCharVar("IASvar", 3)
    elseif (csid == 556) then
        player:tradeComplete()
        player:setCharVar("IASvar", 4)
        player:addKeyItem(tpz.ki.RANPIMONPIS_SPECIAL_STEW)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RANPIMONPIS_SPECIAL_STEW)

    end
end
