-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ailbeche
-- Starts and Finishes Quest: Father and Son, Sharpening the Sword, A Boy's Dream (start)
-- !pos 4 -1 24 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FATHER_AND_SON) == QUEST_COMPLETED and player:getCharVar("returnedAilbecheRod") ~= 1) then
        if (trade:hasItemQty(17391, 1) == true and trade:getItemCount() == 1) then
            player:startEvent(61) -- Finish Quest "Father and Son" (part2) (trading fishing rod)
        end
    end

    if (player:getCharVar("aBoysDreamCS") >= 3) then
        if (trade:hasItemQty(17001, 1) == true and trade:getItemCount() == 1 and player:hasItem(4562) == false) then
            player:startEvent(15) -- During Quest "A Boy's Dream" (trading bug) madame ?
        elseif (trade:hasItemQty(4562, 1) == true and trade:getItemCount() == 1) then
            player:startEvent(47) -- During Quest "A Boy's Dream" (trading odontotyrannus)
        end
    end
end

function onTrigger(player, npc)
    local fatherAndSon = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FATHER_AND_SON)
    local sharpeningTheSword = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SHARPENING_THE_SWORD)
    local aBoysDream = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM)

    -- Checking levels and jobs for af quest
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    -- Check if they have key item "Ordelle whetStone"
    local OrdelleWhetstone = player:hasKeyItem(tpz.ki.ORDELLE_WHETSTONE)
    local sharpeningTheSwordCS = player:getCharVar("sharpeningTheSwordCS")
    local aBoysDreamCS = player:getCharVar("aBoysDreamCS")

    -- "Father and Son" Event Dialogs
    if (fatherAndSon == QUEST_AVAILABLE) then
        player:startEvent(508) -- Start Quest "Father and Son"
    elseif (fatherAndSon == QUEST_ACCEPTED and player:getCharVar("QuestfatherAndSonVar") == 1) then
        player:startEvent(509) -- Finish Quest "Father and Son" (part1)
    elseif (sharpeningTheSword == QUEST_AVAILABLE and player:getCharVar("returnedAilbecheRod") == 1) then
        if (mJob == tpz.job.PLD and mLvl < 40 or mJob ~= tpz.job.PLD) then
            player:startEvent(12) -- Dialog after "Father and Son" (part2)
    -- "Sharpening the Sword" Quest Dialogs
        elseif (mJob == tpz.job.PLD and mLvl >= 40 and sharpeningTheSwordCS == 0) then
            player:startEvent(45) -- Start Quest "Sharpening the Sword" with thank you for the rod
        elseif (mJob == tpz.job.PLD and mLvl >= 40 and sharpeningTheSwordCS == 1) then
            player:startEvent(43) -- Start Quest "Sharpening the Sword"
        end
    elseif (sharpeningTheSword == QUEST_ACCEPTED and OrdelleWhetstone == false) then
        player:startEvent(42) -- During Quest "Sharpening the Sword"
    elseif (sharpeningTheSword == QUEST_ACCEPTED and OrdelleWhetstone == true) then
        player:startEvent(44) -- Finish Quest "Sharpening the Sword"
    -- "A Boy's Dream" Quest Dialogs
    elseif (aBoysDream == QUEST_AVAILABLE and mJob == tpz.job.PLD and mLvl >= 50) then
        if (aBoysDreamCS == 0) then
            player:startEvent(41) -- Start Quest "A Boy's Dream" (long cs)
        else
            player:startEvent(40) -- Start Quest "A Boy's Dream" (shot cs)
        end
    elseif (aBoysDreamCS == 2) then
        player:startEvent(46) -- During Quest "A Boy's Dream"
    elseif (aBoysDreamCS == 3) then
        player:startEvent(39) -- During Quest "A Boy's Dream" (after exoroche cs)
    elseif (aBoysDreamCS == 4) then
        player:startEvent(60) -- During Quest "A Boy's Dream" (after trading bug) madame ?
    elseif (aBoysDreamCS == 5) then
        player:startEvent(47) -- During Quest "A Boy's Dream" (after trading odontotyrannus)
    elseif (aBoysDreamCS >= 6) then
        player:startEvent(25) -- During Quest "A Boy's Dream" (after Zaldon CS)
    elseif (player:hasKeyItem(tpz.ki.KNIGHTS_CONFESSION) and player:getCharVar("UnderOathCS") == 6) then
        player:startEvent(59) -- During Quest "Under Oath" (he's going fishing in Jugner)
    elseif (player:getCharVar("UnderOathCS") == 8) then
        player:startEvent(13) -- During Quest "Under Oath" (After jugner CS)
    else
        player:startEvent(868) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- "Father and Son"
    if (csid == 508) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.FATHER_AND_SON)
    elseif (csid == 509) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17391)
        else
            player:addItem(17391)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17391) -- Willow Fishing Rod
            player:addTitle(tpz.title.LOST_CHILD_OFFICER)
            player:setCharVar("QuestfatherAndSonVar", 0)
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.FATHER_AND_SON)
        end
    elseif (csid == 61) then
        player:setCharVar("returnedAilbecheRod", 1)
        player:addTitle(tpz.title.FAMILY_COUNSELOR)
        player:tradeComplete()
    -- "Sharpening the Sword"
    elseif ((csid == 45 or csid == 43) and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.SHARPENING_THE_SWORD)
        player:setCharVar("sharpeningTheSwordCS", 2)
        player:setCharVar("returnedAilbecheRod", 0)
    elseif (csid == 45 and option == 0) then
        player:setCharVar("sharpeningTheSwordCS", 1)
    elseif (csid == 44) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17643)
        else
            player:delKeyItem(tpz.ki.ORDELLE_WHETSTONE)
            player:addItem(17643)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17643) -- Honor Sword
            player:setCharVar("sharpeningTheSwordCS", 0)
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.SHARPENING_THE_SWORD)
        end
    -- "A Boy's Dream"
    elseif ((csid == 41 or csid == 40) and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM)
        player:setCharVar("aBoysDreamCS", 2)
    elseif (csid == 41 and option == 0) then
        player:setCharVar("aBoysDreamCS", 1)
    elseif (csid == 15 and player:getCharVar("aBoysDreamCS") == 3) then
        player:setCharVar("aBoysDreamCS", 4)
    elseif (csid == 47 and player:getCharVar("aBoysDreamCS") == 4) then
        player:setCharVar("aBoysDreamCS", 5)
    elseif (csid == 25 and player:getCharVar("aBoysDreamCS") == 6) then
        player:setCharVar("aBoysDreamCS", 7)
    elseif (csid == 59) then
        player:setCharVar("UnderOathCS", 7)
    end
end
