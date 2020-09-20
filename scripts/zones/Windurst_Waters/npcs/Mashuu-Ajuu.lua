-----------------------------------
-- Area: Windurst Waters
--  NPC: Mashuu-Ajuu
-- Starts and Finished Quest: Reap What You Sow
-- Involved in Quest: Making the Grade
-- !pos 129 -6 167 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local reapstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW)
    if (reapstatus >= 1 and trade:getItemCount() == 1 and trade:getGil() == 0) then
        if (trade:hasItemQty(4565, 1) == true) then
            player:startEvent(475, 500, 131)                     -- REAP WHAT YOU SOW + GIL: Quest Turn In: Sobbing Fungus turned in
        elseif (trade:hasItemQty(4566, 1) == true) then
            player:startEvent(477, 700)                     -- REAP WHAT YOU SOW + GIL + Stationary Set: Deathball turned in
        end
    end
end

function onTrigger(player, npc)
    local reapstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(448) -- During Making the GRADE
    elseif (reapstatus == QUEST_AVAILABLE) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(463, 0, 4565, 572)                 -- REAP WHAT YOU SOW + HERB SEEDS: QUEST START
        else
            player:startEvent(429)                          -- Standard Conversation
        end
    elseif (reapstatus == QUEST_ACCEPTED) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(464, 0, 4565, 572)                  -- REAP WHAT YOU SOW + HERB SEEDS: OBJECTIVE REMINDER
        else
            player:startEvent(476)                          -- Another Conversation During Quest
        end
    elseif (reapstatus == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(478)                              -- REAP WHAT YOU SOW: After Quest
    elseif (reapstatus == QUEST_COMPLETED and player:needToZone() == false and player:getCharVar("QuestReapSow_var") == 0) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(479, 0, 4565, 572)                -- REAP WHAT YOU SOW + HERB SEEDS: REPEATABLE QUEST START
        else
            player:startEvent(429)                          -- Standard Conversation
        end
    elseif (reapstatus == QUEST_COMPLETED and player:getCharVar("QuestReapSow_var") == 1) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(464, 0, 4565, 572)                  -- REAP WHAT YOU SOW + HERB SEEDS: OBJECTIVE REMINDER
        else
            player:startEvent(476)                          -- Another Conversation During Quest
        end
    else
        player:startEvent(429)                              -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (((csid == 463 and option == 3) or (csid == 479 and option == 3)) and player:getFreeSlotsCount() == 0) then  -- REAP WHAT YOU SOW + HERB SEEDS: QUEST START - ACCEPTED - INVENTORY FULL
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 572)
    elseif (csid == 463 and option == 3) then                      -- REAP WHAT YOU SOW + HERB SEEDS: QUEST START - ACCEPTED
        player:addQuest(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW)
        player:addItem(572)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 572)
    elseif ((csid == 475 or csid == 477) and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED and player:getFreeSlotsCount() == 0) then -- inventory full on quest turn in
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 131)
    elseif (csid == 475) then                                -- REAP WHAT YOU SOW + 500 GIL: Quest Turn In: Sobbing Fungus turned in
        player:addGil(GIL_RATE*500)
        player:tradeComplete(trade)
        player:needToZone(true)
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED) then
            player:completeQuest(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW)
            player:addFame(WINDURST, 75)
            player:addItem(131)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 131)
        elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_COMPLETED) then
            player:addFame(WINDURST, 8)
            player:setCharVar("QuestReapSow_var", 0)
        end
    elseif (csid == 477) then                                -- REAP WHAT YOU SOW + GIL + Stationary Set: Quest Turn In: Deathball turned in
        player:addGil(GIL_RATE*700)
        player:tradeComplete(trade)
        player:needToZone(true)
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED) then
            player:completeQuest(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW)
            player:addFame(WINDURST, 75)
            player:addItem(131)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 131)
        elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_COMPLETED) then
            player:addFame(WINDURST, 8)
            player:setCharVar("QuestReapSow_var", 0)
        end
    elseif (csid == 479 and option == 3) then                 -- REAP WHAT YOU SOW + HERB SEEDS: REPEATABLE QUEST START - ACCEPTED
        player:setCharVar("QuestReapSow_var", 1)
        player:addItem(572)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 572)
    end
end
