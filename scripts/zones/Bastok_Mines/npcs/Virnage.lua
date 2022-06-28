-----------------------------------
-- Area: Bastok Mines
--  NPC: Virnage
-- Starts Quest: Altana's Sorrow
-- !pos 0 0 51 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local altanaSorrow = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ALTANA_S_SORROW)

    if
        altanaSorrow == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4 and
        player:getMainLvl() >= 10
    then
        player:startEvent(141) -- Start quest "Altana's Sorrow"

    elseif altanaSorrow == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.BUCKET_OF_DIVINE_PAINT) then
            player:startEvent(143) -- CS with Bucket of Divine Paint KI
        elseif player:hasKeyItem(xi.ki.LETTER_FROM_VIRNAGE) then
            --player:showText(npc, ID.text.VIRNAGE_DIALOG_2)
            player:startEvent(144) -- During quest (after KI)
        else
            -- player:showText(npc, ID.text.VIRNAGE_DIALOG_1)
            player:startEvent(142) -- During quest "Altana's Sorrow" (before KI)
        end

    elseif altanaSorrow == QUEST_COMPLETED then
        player:startEvent(145) -- New standard dialog

    else
        player:startEvent(140) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 141 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ALTANA_S_SORROW)
    elseif csid == 143 then
        player:delKeyItem(xi.ki.BUCKET_OF_DIVINE_PAINT)
        player:addKeyItem(xi.ki.LETTER_FROM_VIRNAGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_VIRNAGE)
    end
end

return entity
