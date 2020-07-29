-----------------------------------
--  Area: Western Adoulin
--  NPC: Flapno
--  Type: Standard NPC, Quest NPC, and Shop NPC
--  Starts, Involved with, and Finishes Quest: 'Exotic Delicacies'
--  Involved with Quest: 'All the Way to the Bank'
--  !pos 70 0 -13 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    local exoticDelacacies = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.EXOTIC_DELICACIES)

    -- ALL THE WAY TO THE BANK
    if (player:hasKeyItem(tpz.ki.TARUTARU_SAUCE_INVOICE) and npcUtil.tradeHas( trade, {{"gil", 5600}} )) then
        local ATWTTB_Paid_Flapano = player:getMaskBit(player:getCharVar("ATWTTB_Payments"), 2)
        if (not ATWTTB_Paid_Flapano) then
            player:startEvent(5071)
        end

    -- EXOTIC DELICACIES
    elseif (exoticDelacacies == QUEST_ACCEPTED) then
        if (npcUtil.tradeHas( trade, {3916, 5949, {5954, 2}} )) then
            player:startEvent(2861)
        elseif (npcUtil.tradeHas(trade, 5974) or npcUtil.tradeHas(trade, 5975)) then
            player:startEvent(2862)
        end
    end
end

function onTrigger(player, npc)
    local theWeatherspoonWar = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.THE_WEATHERSPOON_WAR)
    local exoticDelacacies = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.EXOTIC_DELICACIES)

    -- THE WEATHERSPOON WAR
    if (theWeatherspoonWar == QUEST_ACCEPTED and player:getCharVar("Weatherspoon_War_Status") == 6) then
        player:startEvent(191)

    -- EXOTIC DELICACIES
    -- Flapano offers his quest every other time the player talks to him
    elseif (exoticDelacacies ~= QUEST_COMPLETED and player:getCharVar("Flapano_Odd_Even") == 0) then
        if (exoticDelicacies == QUEST_AVAILABLE) then
            player:startEvent(2860)
        elseif (exoticDelicacies == QUEST_ACCEPTED) then
            player:startEvent(2863)
        end

        player:setCharVar("Flapano_Odd_Even", 1)

    -- SHOP
    else
        player:showText(npc, ID.text.FLAPANO_SHOP_TEXT)
        local stock =
        {
            5943, 125,   -- Smoked Mackerel
            4415, 124,   -- Roasted Corn
            4434, 5000,  -- Mushroom Risotto
            5145, 5600,  -- Fish and Chips
            4423, 300,   -- Apple Juice
            4405, 160,   -- Rice Ball
            5676, 76475, -- Mushroom Saute
        }
        tpz.shop.general(player, stock)

        if (exoticDelicacies ~= QUEST_COMPLETED) then
            player:setCharVar("Flapano_Odd_Even", 0)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- ALL THE WAY TO THE BANK
    if (csid == 5071) then
        player:confirmTrade()
        player:setMaskBit("ATWTTB_Payments", 2, true)
        if (player:isMaskFull(player:getCharVar("ATWTTB_Payments"), 5)) then
            npcUtil.giveKeyItem(tpz.ki.TARUTARU_SAUCE_RECEIPT)
        end

    -- EXOTIC DELICACIES
    elseif (csid == 2860 and option == 1) then
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.EXOTIC_DELICACIES)
    elseif (csid == 2861) then
        if (npcUtil.completeQuest(player, ADOULIN, tpz.quest.id.adoulin.EXOTIC_DELICACIES, {bayld=500, item=5975, xp=1000})) then
            player:confirmTrade()
            player:setCharVar("Flapano_Odd_Even", 0)
        end
    end
end
