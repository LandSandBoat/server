-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Narcheral
-- Starts and Finishes Quest: Messenger from Beyond, Prelude of Black and White (Finish), Pieuje's Decision (Finish)
-- !pos 129 -11 126 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1096, 1) and trade:getItemCount() == 1) then -- Trade Tavnazia Pass
            player:startEvent(690) -- Finish quest "Messenger from Beyond"
        end
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1097, 1) and trade:hasItemQty(12995, 1) and trade:getItemCount() == 2) then -- Trade Yagudo Holy Water & Moccasins
            player:startEvent(691) -- Finish quest "Prelude of Black and White"
        end
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PIEUJE_S_DECISION) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(13842, 1) and trade:getItemCount() == 1) then -- Trade Tavnazian Mask
            player:startEvent(692) -- Finish quest "Pieuje's Decision"
        end
    end
end

function onTrigger(player, npc)

    messengerFromBeyond = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND)

    -- Checking levels and jobs for af quest
    mLvl = player:getMainLvl()
    mJob = player:getMainJob()

    if (messengerFromBeyond == QUEST_AVAILABLE and mJob == tpz.job.WHM and mLvl >= AF1_QUEST_LEVEL) then
        player:startEvent(689) -- Start quest "Messenger from Beyond"
    else
        player:startEvent(688) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 689) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND)
    elseif (csid == 690) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17422)
        else
            player:addItem(17422)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17422) -- Blessed Hammer
            player:tradeComplete()
            player:addFame(SANDORIA, 20)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND)
        end
    elseif (csid == 691) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14091) -- Healer's Duckbills
        else
            player:addItem(14091)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14091) -- Healer's Duckbills
            player:tradeComplete()
            player:addFame(SANDORIA, 40)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE)
        end
    elseif (csid == 692) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12640) -- Healer's Briault
        else
            player:addTitle(tpz.title.PARAGON_OF_WHITE_MAGE_EXCELLENCE)
            player:setCharVar("pieujesDecisionCS", 0)
            player:addItem(12640)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12640) -- Healer's Briault
            player:tradeComplete()
            player:addFame(SANDORIA, 60)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.PIEUJE_S_DECISION)
        end
    end

end
