-----------------------------------
-- Area: Windurst Walls
--  NPC: Ambrosius
--
-- Quest NPC for "The Postman Always KOs Twice"
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrigger(player, npc)
    QuestStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)

    if (QuestStatus == QUEST_AVAILABLE) then
        player:startEvent(48)
    elseif (QuestStatus == QUEST_ACCEPTED) then
        player:startEvent(49)
    elseif (QuestStatus == QUEST_COMPLETED) then
        player:startEvent(56)
    end
end

function onTrade(player, npc, trade)
    QuestStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)

    if (QuestStatus ~= QUEST_AVAILABLE) then
        reward = 0

        if (trade:hasItemQty(584, 1)) then reward = reward+1 end
        if (trade:hasItemQty(585, 1)) then reward = reward+1 end
        if (trade:hasItemQty(586, 1)) then reward = reward+1 end
        if (trade:hasItemQty(587, 1)) then reward = reward+1 end

        if (trade:getItemCount() == reward) then
            if (reward == 1) then
                if (QuestStatus == QUEST_ACCEPTED) then
                    player:startEvent(52, GIL_RATE*50)
                elseif (QuestStatus == QUEST_COMPLETED) then
                    player:startEvent(57, GIL_RATE*50)
                end
            elseif (reward == 2) then
                if (QuestStatus == QUEST_ACCEPTED) then
                    player:startEvent(53, GIL_RATE*150, 2)
                elseif (QuestStatus == QUEST_COMPLETED) then
                    player:startEvent(58, GIL_RATE*150, 2)
                end
            elseif (reward == 3) then
                if (QuestStatus == QUEST_ACCEPTED) then
                    player:startEvent(54, GIL_RATE*250, 3)
                elseif (QuestStatus == QUEST_COMPLETED) then
                    player:startEvent(59, GIL_RATE*250, 3)
                end
            elseif (reward == 4) then
                if (QuestStatus == QUEST_ACCEPTED) then
                    player:startEvent(55, GIL_RATE*500, 4)
                elseif (QuestStatus == QUEST_COMPLETED) then
                    player:startEvent(60, GIL_RATE*500, 4)
                end
            end
        end
    end
end

function onEventUpdate(player, csid, option)
    -- printf("Update CSID: %u", csid)
end

function onEventFinish(player, csid, option)
    -- printf("Finish CSID: %u", csid)

    if (csid == 48 and option == 0) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif (csid == 52) then
        player:tradeComplete()
        player:addGil(GIL_RATE*50)
        player:addFame(WINDURST, 80)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif (csid == 53) then
        player:tradeComplete()
        player:addGil(GIL_RATE*150)
        player:addFame(WINDURST, 80)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif (csid == 54) then
        player:tradeComplete()
        player:addGil(GIL_RATE*250)
        player:addFame(WINDURST, 80)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif (csid == 55) then
        player:tradeComplete()
        player:addGil(GIL_RATE*500)
        player:addFame(WINDURST, 80)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif (csid == 57) then
        player:tradeComplete()
        player:addGil(GIL_RATE*50)
        player:addFame(WINDURST, 5)
    elseif (csid == 58) then
        player:tradeComplete()
        player:addGil(GIL_RATE*150)
        player:addFame(WINDURST, 15)
    elseif (csid == 59) then
        player:tradeComplete()
        player:addGil(GIL_RATE*250)
        player:addFame(WINDURST, 25)
    elseif (csid == 60) then
        player:tradeComplete()
        player:addGil(GIL_RATE*500)
        player:addFame(WINDURST, 50)
    end
end
