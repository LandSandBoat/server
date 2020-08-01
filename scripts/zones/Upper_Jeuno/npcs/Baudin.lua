-----------------------------------
-- Area: Upper Jeuno
--  NPC: Baudin
-- Starts and Finishes Quest: Crest of Davoi, Save My Sister
-- Involved in Quests: Save the Clock Tower
-- !pos -75 0 80 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(555, 1) and trade:getItemCount() == 1) then
        local a = player:getCharVar("saveTheClockTowerNPCz2") -- NPC Zone2
        if (a == 0 or (a ~= 32 and a ~= 96 and a ~= 160 and a ~= 288 and a ~= 544 and a ~= 224 and a ~= 800 and a ~= 352 and
           a ~= 672 and a ~= 416 and a ~= 608 and a ~= 480 and a ~= 736 and a ~= 864 and a ~= 928 and a ~= 992)) then
            player:startEvent(177, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CREST_OF_DAVOI) == QUEST_ACCEPTED and trade:hasItemQty(4377, 1) and trade:getItemCount() == 1) then
        player:startEvent(171) -- Finish Quest "Crest of Davoi" Start Quest "Save my Sister" with var, not addquest()
    end
end

function onTrigger(player, npc)
    local CrestOfDavoi = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CREST_OF_DAVOI)
    local SaveMySister = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SAVE_MY_SISTER)

    -- You need to talk to Aldo before you can obtain the Crest of Davoi or Yagudo Torch
    if (player:hasKeyItem(tpz.ki.SILVER_BELL) and CrestOfDavoi == QUEST_AVAILABLE) then
        player:startEvent(174) -- Start Quest "Crest of Davoi"
    elseif (CrestOfDavoi == QUEST_ACCEPTED) then
        player:startEvent(175) -- During Quest "Crest of Davoi"
    elseif (CrestOfDavoi == QUEST_COMPLETED and SaveMySister == QUEST_AVAILABLE and player:getCharVar("saveMySisterVar") == 1) then
        player:startEvent(172) -- During Quest "Save my Sister" (before speak with Mailloquetat)
    elseif (CrestOfDavoi == QUEST_COMPLETED and player:getCharVar("saveMySisterVar") == 2) then
        player:startEvent(105) -- During Quest "Save my Sister" (after speak with Mailloquetat)
    elseif (SaveMySister == QUEST_ACCEPTED and player:getCharVar("saveMySisterFireLantern") < 4) then
        player:startEvent(27) -- During Quest "Save my Sister" (after speak with Neraf-Najiruf)
    elseif (SaveMySister == QUEST_ACCEPTED and player:getCharVar("saveMySisterFireLantern") == 4) then
        player:startEvent(107) -- Ending Quest "Save my Sister"
    elseif (SaveMySister == QUEST_COMPLETED) then
        player:startEvent(176) -- New standard dialog after "Save my Sister"
    else
        player:startEvent(122) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 177) then --1
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz2", 32)
    elseif (csid == 174 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.CREST_OF_DAVOI)
    elseif (csid == 171) then
        player:tradeComplete()
        player:setCharVar("saveMySisterVar", 1)
        player:addKeyItem(tpz.ki.CREST_OF_DAVOI_KI)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CREST_OF_DAVOI_KI)
        player:addFame(JEUNO, 30)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.CREST_OF_DAVOI)

    elseif (csid == 105) then
        player:setCharVar("saveMySisterVar", 3)
    elseif (csid == 107) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17041)
        else
            player:addTitle(tpz.title.EXORCIST_IN_TRAINING)
            player:addGil(GIL_RATE*3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
            player:addItem(17041)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17041)
            player:tradeComplete()
            player:addFame(JEUNO, 30)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.SAVE_MY_SISTER)
        end
    end
end
