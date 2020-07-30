-----------------------------------
-- Area: Mhaura
--  NPC: Orlando
-- Type: Standard NPC
-- !pos -37.268 -9 58.047 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local QuestStatus = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ORLANDO_S_ANTIQUES)
    local itemID = trade:getItemId()
    local itemList =
    {
        {564, 200},   -- Fingernail Sack
        {565, 250},   -- Teeth Sack
        {566, 200},   -- Goblin Cup
        {568, 120},   -- Goblin Die
        {656, 600},   -- Beastcoin
        {748, 900},   -- Gold Beastcoin
        {749, 800},   -- Mythril Beastcoin
        {750, 750},   -- Silver Beastcoin
        {898, 120},   -- Chicken Bone
        {900, 100},   -- Fish Bone
        {16995, 150}, -- Rotten Meat
    }

    for x, item in pairs(itemList) do
        if (QuestStatus == QUEST_ACCEPTED) or (player:getLocalVar("OrlandoRepeat") == 1) then
            if (item[1] == itemID) then
                if (trade:hasItemQty(itemID, 8) and trade:getItemCount() == 8) then
                    -- Correct amount, valid item.
                    player:setCharVar("ANTIQUE_PAYOUT", (GIL_RATE*item[2]))
                    player:startEvent(102, GIL_RATE*item[2], itemID)
                elseif (trade:getItemCount() < 8) then
                    -- Wrong amount, but valid item.
                    player:startEvent(104)
                end
            end
        end
    end
end

function onTrigger(player, npc)
    local QuestStatus = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ORLANDO_S_ANTIQUES)

    if (player:getFameLevel(WINDURST) >= 2) then
        if (player:hasKeyItem(tpz.ki.CHOCOBO_LICENSE)) then
            if (QuestStatus ~= QUEST_AVAILABLE) then
                player:startEvent(103)
            elseif (QuestStatus == QUEST_AVAILABLE) then
                player:startEvent(101)
            end
        else
            player:startEvent(100)
        end
    else
        player:startEvent(106)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local QuestStatus = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ORLANDO_S_ANTIQUES)
    local payout = player:getCharVar("ANTIQUE_PAYOUT")

    if (csid == 101) then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ORLANDO_S_ANTIQUES)
    elseif (csid == 102) then
        player:tradeComplete()
        player:addFame(WINDURST, 10)
        player:addGil(payout)
        player:messageSpecial(ID.text.GIL_OBTAINED, payout)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ORLANDO_S_ANTIQUES)
        player:setCharVar("ANTIQUE_PAYOUT", 0)
        player:setLocalVar("OrlandoRepeat", 0)
    elseif (csid == 103) then
        if (QuestStatus == QUEST_COMPLETED) then
            player:setLocalVar("OrlandoRepeat", 1)
        end
    end
end
