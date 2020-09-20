-----------------------------------
-- Area: Bastok Mines
--  NPC: Virnage
-- Starts Quest: Altana's Sorrow
-- !pos 0 0 51 234
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    AltanaSorrow = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.ALTANA_S_SORROW)

    if (AltanaSorrow == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 4 and player:getMainLvl() >= 10) then
        player:startEvent(141) -- Start quest "Altana's Sorrow"
    elseif (AltanaSorrow == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.BUCKET_OF_DIVINE_PAINT) == true) then
            player:startEvent(143) -- CS with Bucket of Divine Paint KI
        elseif (player:hasKeyItem(tpz.ki.LETTER_FROM_VIRNAGE) == true) then
            --player:showText(npc, ID.text.VIRNAGE_DIALOG_2)
            player:startEvent(144) -- During quest (after KI)
        else
            -- player:showText(npc, ID.text.VIRNAGE_DIALOG_1)
            player:startEvent(142) -- During quest "Altana's Sorrow" (before KI)
        end
    elseif (AltanaSorrow == QUEST_COMPLETED) then
        player:startEvent(145) -- New standard dialog
    else
        player:startEvent(140) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 141 and option == 0) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.ALTANA_S_SORROW)
    elseif (csid == 143) then
        player:delKeyItem(tpz.ki.BUCKET_OF_DIVINE_PAINT)
        player:addKeyItem(tpz.ki.LETTER_FROM_VIRNAGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_FROM_VIRNAGE)
    end
end
