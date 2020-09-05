-----------------------------------
-- Area: Port Bastok
--  NPC: Talib
-- Starts Quest: Beauty and the Galka
-- Starts & Finishes Quest: Shady Business
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SHADY_BUSINESS) >= QUEST_ACCEPTED) then
        if (trade:hasItemQty(642, 4) and trade:getItemCount() == 4) then
            player:startEvent(91)
        end
    elseif (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BEAUTY_AND_THE_GALKA) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(642, 1) and trade:getItemCount() == 1) then
            player:startEvent(3)
        end
    end

end

function onTrigger(player, npc)

    BeautyAndTheGalka = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BEAUTY_AND_THE_GALKA)

    if (BeautyAndTheGalka == QUEST_COMPLETED) then
        player:startEvent(90)
    elseif (BeautyAndTheGalka == QUEST_ACCEPTED or player:getCharVar("BeautyAndTheGalkaDenied") >= 1) then
        player:startEvent(4)
    else
        player:startEvent(2)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)

end

function onEventFinish(player, csid, option)

    if (csid == 2 and option == 0) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.BEAUTY_AND_THE_GALKA)
    elseif (csid == 2 and option == 1) then
        player:setCharVar("BeautyAndTheGalkaDenied", 1)
    elseif (csid == 3) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.PALBOROUGH_MINES_LOGS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PALBOROUGH_MINES_LOGS)
    elseif (csid == 90) then
        ShadyBusiness = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SHADY_BUSINESS)

        if (ShadyBusiness == QUEST_AVAILABLE) then
            player:addQuest(BASTOK, tpz.quest.id.bastok.SHADY_BUSINESS)
        end
    elseif (csid == 91) then
        ShadyBusiness = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SHADY_BUSINESS)

        if (ShadyBusiness == QUEST_ACCEPTED) then
            player:addFame(NORG, 100)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.SHADY_BUSINESS)
        else
            player:addFame(NORG, 80)
        end

        player:tradeComplete()
        player:addGil(GIL_RATE*350)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*350)
    end

end
