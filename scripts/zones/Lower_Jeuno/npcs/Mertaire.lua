-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Mertaire
-- Starts and Finishes Quest: The Old Monument (start only), A Minstrel in Despair, Painful Memory (BARD AF1)
-- !pos -17 0 -61 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local poeticParchmentID = 634

entity.onTrade = function(player, npc, trade)
    -- A MINSTREL IN DESPAIR (poetic parchment)
    if
        trade:hasItemQty(poeticParchmentID, 1) and
        trade:getItemCount() == 1 and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == QUEST_AVAILABLE
    then
        player:startEvent(101)
    end
end

entity.onTrigger = function(player, npc)
    local painfulMemory  = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)
    local circleOfTime   = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local job            = player:getMainJob()
    local level          = player:getMainLvl()

    -- PAINFUL MEMORY (Bard AF1)
    if
        painfulMemory == QUEST_AVAILABLE and
        job == xi.job.BRD and
        level >= xi.settings.main.AF1_QUEST_LEVEL
    then
        if player:getCharVar("PainfulMemoryCS") == 0 then
            player:startEvent(138) -- Long dialog for "Painful Memory"
        else
            player:startEvent(137) -- Short dialog for "Painful Memory"
        end

    elseif painfulMemory == QUEST_ACCEPTED then
        player:startEvent(136) -- During Quest "Painful Memory"

    -- CIRCLE OF TIME (Bard AF3)
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == QUEST_COMPLETED and
        circleOfTime == QUEST_AVAILABLE and
        job == xi.job.BRD and
        level >= xi.settings.main.AF3_QUEST_LEVEL
    then
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- A MINSTREL IN DESPAIR
    if csid == 101 then
        npcUtil.giveCurrency(player, 'gil', 2100)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
        player:addFame(xi.quest.fame_area.JEUNO, 30)

        -- Placing this here allows the player to get additional poetic
        -- parchments should they drop them until this quest is complete
        player:setCharVar("TheOldMonument_Event", 0)

    -- PAINFUL MEMORY (Bard AF1)
    elseif csid == 138 and option == 0 then
        player:setCharVar("PainfulMemoryCS", 1) -- player declined quest

    elseif
        (csid == 137 or csid == 138) and
        option == 1
    then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)
        player:setCharVar("PainfulMemoryCS", 0)
        player:addKeyItem(xi.ki.MERTAIRES_BRACELET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MERTAIRES_BRACELET)

    -- CIRCLE OF TIME (Bard AF3)
    elseif csid == 139 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
        player:setCharVar("circleTime", 1)
    end
end

return entity
