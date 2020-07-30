-----------------------------------
-- Area: Bastok Mines
--  NPC: Tami
-- Involved In Quest: Groceries
-- !pos 62.617 0.000 -68.222 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
    local groceries = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GROCERIES)
    local groceriesProgress = player:getCharVar("Groceries")

    -- GROCERIES (trade meat jerky)
    if (groceries == QUEST_ACCEPTED and groceriesProgress == 3 and trade:getItemCount() == 1 and trade:hasItemQty(4376, 1)) then
        player:startEvent(113)
    end
end

function onTrigger(player, npc)
    local groceries = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GROCERIES)
    local groceriesProgress = player:getCharVar("Groceries")

    -- GROCERIES
    if (groceries == QUEST_AVAILABLE or (groceries == QUEST_ACCEPTED and groceriesProgress == 0)) then
        player:startEvent(110)
    elseif (groceries == QUEST_ACCEPTED and groceriesProgress == 1) then
        player:showText(npc, ID.text.TAMI_MY_HUSBAND)
    elseif (groceries == QUEST_ACCEPTED and groceriesProgress == 2) then
        player:startEvent(112)
    elseif (groceries == QUEST_ACCEPTED and groceriesProgress == 3) then
        player:startEvent(111)

    -- DEFAULT DIALOG
    else
        player:startEvent(115)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- GROCERIES
    if (csid == 110) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.GROCERIES)
        player:addKeyItem(tpz.ki.TAMIS_NOTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TAMIS_NOTE)
        player:setCharVar("Groceries", 1)
    elseif (csid == 112) then
        player:addFame(BASTOK, 8)
        player:setCharVar("Groceries", 0)
        player:addGil(GIL_RATE*10)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10)
    elseif (csid == 113) then
        if (player:getFreeSlotsCount() >= 1) then
            player:tradeComplete()
            player:setCharVar("Groceries", 0)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.GROCERIES)
            player:addFame(BASTOK, 75)
            player:addItem(13594) -- Rabbit Mantle
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13594)
        else
            player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, 13594)
        end
    end
end
