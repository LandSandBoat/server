-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Harith
-- Type: Standard NPC
-- !pos -4.349 1 134.014 243
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES) >= QUEST_ACCEPTED) then
        local count = trade:getItemCount()
        local reward = 0
        local anima = 0

        if (trade:hasItemQty(1759, 1) and count == 1) then -- Recollection of Suffering --> Hamayumi
            reward = 17208
        elseif (trade:hasItemQty(1760, 1) and count == 1) then -- Recollection of Animosity --> Dia Wand
            reward = 17466
        elseif (trade:hasItemQty(1761, 1) and count == 1) then -- Recollection of Anxiety --> Stone Gorget
            reward = 13177
        elseif (trade:hasItemQty(1688, 1) and count == 2) then -- Recollection of Pain --> Hysteroanima (Amnesia)
            anima = 5262
        elseif (trade:hasItemQty(1689, 1) and count == 2) then -- Recollection of Guilt --> Terroanima (Run in Terror)
            anima = 5263
        elseif (trade:hasItemQty(1687, 1) and count == 2) then -- Recollection of Fear --> Psychoanima (Intimidation)
            anima = 5261
        end

        if (reward > 7000) then
            if (player:getFreeSlotsCount() >= 1) then
                player:setCharVar("harithreward", reward)
                player:startEvent(110)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
            end
        elseif (anima > 5000) then
            if (player:getFreeSlotsCount() == 0) then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, anima)
            elseif (trade:getGil() ~= 2000) then
                player:startEvent(108, 2000)
            else
                player:setCharVar("harithreward", anima)
                player:startEvent(109)
            end
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(COP) == xi.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(113)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES) == QUEST_AVAILABLE and player:getCurrentMission(COP) >= xi.mission.id.cop.THE_MOTHERCRYSTALS) then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES)
        player:startEvent(114)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES) >= QUEST_ACCEPTED) then
        player:startEvent(114)
    else
        player:startEvent(111)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 110 or csid == 109) then
        local objecttrade = player:getCharVar("harithreward")

        player:tradeComplete()
        player:addItem(objecttrade)
        player:messageSpecial(ID.text.ITEM_OBTAINED, objecttrade)
        player:setCharVar("harithreward", 0)
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES) == QUEST_ACCEPTED) then
            player:addFame(JEUNO, 30)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES)
        else
            player:addFame(JEUNO, 5)
        end
    end

end

return entity
