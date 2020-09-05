-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Abeaule
-- Starts and Finishes Quest: The Trader in the Forest, The Medicine Woman
-- !pos -136 -2 56 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    theTraderInTheForest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)

    if (theTraderInTheForest == QUEST_ACCEPTED) then
        if (trade:hasItemQty(4367, 1) and trade:getItemCount() == 1) then -- Trade Batagreens
            player:startEvent(525)
        end
    end

end

function onTrigger(player, npc)

    theTraderInTheForest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
    medicineWoman = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_MEDICINE_WOMAN)

    if (theTraderInTheForest == QUEST_AVAILABLE) then
        if (player:getCharVar("theTraderInTheForestCS") == 1) then
            player:startEvent(592)
        else
            player:startEvent(524)
            player:setCharVar("theTraderInTheForestCS", 1)
        end
    elseif (theTraderInTheForest == QUEST_ACCEPTED) then
        player:startEvent(593)
    elseif (theTraderInTheForest == QUEST_COMPLETED and medicineWoman == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3) then
        if (player:getCharVar("medicineWomanCS") == 1) then
            player:startEvent(615)
        else
            player:startEvent(613)
            player:setCharVar("medicineWomanCS", 1)
        end
    elseif (player:hasKeyItem(tpz.ki.COLD_MEDICINE)) then
        player:startEvent(614)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- "The Trader in the Forest" Quest
    if (csid == 524 and option == 0 or csid == 592 and option == 0) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 592)
        else
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
            player:setCharVar("theTraderInTheForestCS", 0)
            player:addItem(592)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 592) -- Supplies Order
        end
    elseif (csid == 593 and option == 1) then
        local SUPPLIES_ORDER = 592
        if (player:getFreeSlotsCount() > 0 and player:hasItem(592) == false) then -- Supplies Order
            player:addItem(SUPPLIES_ORDER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, SUPPLIES_ORDER)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, SUPPLIES_ORDER)
        end
    elseif (csid == 525) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12600) -- Robe
        else
            player:tradeComplete()
            player:addTitle(tpz.title.GREEN_GROCER)
            player:addItem(12600)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12600) -- Robe
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
        end
    -- "The Medicine Woman" Quest
    elseif (csid == 613 and option == 0 or csid == 615 and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_MEDICINE_WOMAN)
    elseif (csid == 614) then
        player:addTitle(tpz.title.TRAVELING_MEDICINE_MAN)
        player:delKeyItem(tpz.ki.COLD_MEDICINE)
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
        player:addFame(SANDORIA, 30)
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_MEDICINE_WOMAN)
    end

end
