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
local entity = {}

entity.onTrade = function(player, npc, trade)
    local theTraderInTheForest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)

    if theTraderInTheForest == QUEST_ACCEPTED then
        if trade:hasItemQty(4367, 1) and trade:getItemCount() == 1 then -- Trade Batagreens
            player:startEvent(525)
        end
    end
end

entity.onTrigger = function(player, npc)
    local theTraderInTheForest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
    local medicineWoman = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)

    if theTraderInTheForest == QUEST_AVAILABLE then
        if player:getCharVar("theTraderInTheForestCS") == 1 then
            player:startEvent(592)
        else
            player:startEvent(524)
            player:setCharVar("theTraderInTheForestCS", 1)
        end
    elseif theTraderInTheForest == QUEST_ACCEPTED then
        player:startEvent(593)
    elseif theTraderInTheForest == QUEST_COMPLETED and medicineWoman == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3 then
        if player:getCharVar("medicineWomanCS") == 1 then
            player:startEvent(615)
        else
            player:startEvent(613)
            player:setCharVar("medicineWomanCS", 1)
        end
    elseif medicineWoman == QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.COLD_MEDICINE) then
            player:showText(npc, ID.text.ABEAULE_DIALOG_HOME)
        else
            player:startEvent(614)
        end
    else
        player:showText(npc, ID.text.ABEAULE_DIALOG_THANKS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- "The Trader in the Forest" Quest
    if (csid == 524 and option == 0) or (csid == 592 and option == 0) then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 592)
        else
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
            player:setCharVar("theTraderInTheForestCS", 0)
            player:addItem(592)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 592) -- Supplies Order
        end
    elseif csid == 593 and option == 1 then
        local SUPPLIES_ORDER = 592
        if player:getFreeSlotsCount() > 0 and player:hasItem(592) == false then -- Supplies Order
            player:addItem(SUPPLIES_ORDER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, SUPPLIES_ORDER)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, SUPPLIES_ORDER)
        end
    elseif csid == 525 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12600) -- Robe
        else
            player:tradeComplete()
            player:addTitle(xi.title.GREEN_GROCER)
            player:addItem(12600)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12600) -- Robe
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)
        end
    -- "The Medicine Woman" Quest
    elseif (csid == 613 and option == 0) or (csid == 615 and option == 0) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    elseif csid == 614 then
        player:addTitle(xi.title.TRAVELING_MEDICINE_MAN)
        player:delKeyItem(xi.ki.COLD_MEDICINE)
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
        player:addFame(SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    end
end

return entity
