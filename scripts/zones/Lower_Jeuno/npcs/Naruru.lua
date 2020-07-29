-----------------------------------
-- Area: Lower Jeuno
--  NPC: Naruru
-- Starts and Finishes Quests: Cook's Pride
-- !pos -56 0.1 -138 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TheWonderMagicSet = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_WONDER_MAGIC_SET)
    local CooksPride = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COOK_S_PRIDE)
    local TheKindCardian = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_KIND_CARDIAN)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 13) == false) then
        player:startEvent(10053)
    elseif (TheWonderMagicSet == QUEST_COMPLETED and CooksPride == QUEST_AVAILABLE) then
        if (player:getCharVar("CooksPrideVar") == 0) then
            player:startEvent(189) -- Start quest "Cook's pride" Long CS
        else
            player:startEvent(188) -- Start quest "Cook's pride" Short CS
        end
    elseif (CooksPride == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SUPER_SOUP_POT) == false) then
        player:startEvent(186) -- During quest "Cook's pride"
    elseif (player:hasKeyItem(tpz.ki.SUPER_SOUP_POT) == true) then
        player:startEvent(187) -- Finish quest "Cook's pride"
    elseif (CooksPride == QUEST_COMPLETED and TheKindCardian == QUEST_AVAILABLE) then
        if (player:getCharVar("theLostCardianVar") == 0) then
            player:startEvent(31) -- During quests "The lost cardian"
        else
            player:startEvent(71) -- During quests "The lost cardian"
        end
    elseif (CooksPride == QUEST_COMPLETED and TheKindCardian ~= QUEST_COMPLETED) then
        player:startEvent(71) -- During quests "The kind cardien"
    elseif (TheKindCardian == QUEST_COMPLETED) then
        player:startEvent(72) -- New standard dialog after the quest "The kind cardien"
    else
        player:startEvent(98) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if ((csid == 189 or csid == 188) and option == 0) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.COOK_S_PRIDE)
    elseif (csid == 189 and option == 1) then
        player:setCharVar("CooksPrideVar", 1)
    elseif (csid == 187) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13446)
        else
            player:addTitle(tpz.title.MERCY_ERRAND_RUNNER)
            player:delKeyItem(tpz.ki.SUPER_SOUP_POT)
            player:setCharVar("CooksPrideVar", 0)
            player:addGil(GIL_RATE*3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
            player:addItem(13446)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13446) -- Mythril Ring
            player:addFame(JEUNO, 30)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.COOK_S_PRIDE)
        end
    elseif (csid == 10053) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 13, true)
    end
end
