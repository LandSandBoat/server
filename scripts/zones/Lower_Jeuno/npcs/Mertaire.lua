-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Mertaire
-- Starts and Finishes Quest: The Old Monument (start only), A Minstrel in Despair, Painful Memory (BARD AF1)
-- !pos -17 0 -61 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

local POETIC_PARCHMENT = 634

function onTrade(player, npc, trade)
    local theOldMonument = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_OLD_MONUMENT)
    local aMinstrelInDespair = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)

    -- A MINSTREL IN DESPAIR (poetic parchment)
    if trade:hasItemQty(POETIC_PARCHMENT, 1) and trade:getItemCount() == 1 and theOldMonument == QUEST_COMPLETED and aMinstrelInDespair == QUEST_AVAILABLE then
        player:startEvent(101)
    end
end

function onTrigger(player, npc)
    local theOldMonument = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_OLD_MONUMENT)
    local painfulMemory = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.PAINFUL_MEMORY)
    local theRequiem = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)
    local circleOfTime = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local job = player:getMainJob()
    local level = player:getMainLvl()

    -- THE OLD MONUMENT
    if theOldMonument == QUEST_AVAILABLE and level >= ADVANCED_JOB_LEVEL then
        player:startEvent(102)

    -- PAINFUL MEMORY (Bard AF1)
    elseif painfulMemory == QUEST_AVAILABLE and job == tpz.job.BRD and level >= AF1_QUEST_LEVEL then
        if player:getCharVar("PainfulMemoryCS") == 0 then
            player:startEvent(138) -- Long dialog for "Painful Memory"
        else
            player:startEvent(137) -- Short dialog for "Painful Memory"
        end
    elseif painfulMemory == QUEST_ACCEPTED then
        player:startEvent(136) -- During Quest "Painful Memory"

    -- CIRCLE OF TIME (Bard AF3)
    elseif theRequiem == QUEST_COMPLETED and circleOfTime == QUEST_AVAILABLE and job == tpz.job.BRD and level >= AF3_QUEST_LEVEL then
        player:startEvent(139) -- Start "The Circle of Time"
    elseif circleOfTime == QUEST_ACCEPTED then
        player:messageSpecial(ID.text.MERTAIRE_RING)

    -- DEFAULT DIALOG
    elseif painfulMemory == QUEST_COMPLETED then
        player:startEvent(135) -- Standard dialog after completed "Painful Memory"
    else
        player:messageSpecial(ID.text.MERTAIRE_DEFAULT)

    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- THE OLD MONUMENT
    if csid == 102 then
        player:setCharVar("TheOldMonument_Event", 1)

    -- A MINSTREL IN DESPAIR
    elseif csid == 101 then
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
        player:tradeComplete()
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
        player:addFame(JEUNO, 30)

        -- Placing this here allows the player to get additional poetic
        -- parchments should they drop them until this quest is complete
        player:setCharVar("TheOldMonument_Event", 0)

    -- PAINFUL MEMORY (Bard AF1)
    elseif csid == 138 and option == 0 then
        player:setCharVar("PainfulMemoryCS", 1) -- player declined quest
    elseif (csid == 137 or csid == 138) and option == 1 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.PAINFUL_MEMORY)
        player:setCharVar("PainfulMemoryCS", 0)
        player:addKeyItem(tpz.ki.MERTAIRES_BRACELET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MERTAIRES_BRACELET)

    -- CIRCLE OF TIME (Bard AF3)
    elseif csid == 139 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_CIRCLE_OF_TIME)
        player:setCharVar("circleTime", 1)
    end
end
