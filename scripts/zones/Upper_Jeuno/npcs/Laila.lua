-----------------------------------
-- Area: Upper Jeuno
--  NPC: Laila
-- Type: Job Quest Giver
-- !pos -54.045 -1 100.996 244
-----------------------------------
--TODO--
-- make sure the surrounding npcs react to the player accordingly after each quest. There are a few event IDs that I don't recall using
-- make global variables for all these event hexvalues and put them in textids
--TODO--
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if ((player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_AVAILABLE
        or (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_COMPLETED
        and player:hasItem(19203) == false))
        and player:getMainJob() == xi.job.DNC and player:getMainLvl()>=40) then

        player:startEvent(10129)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1") == 5 and player:seenKeyItem(xi.ki.THE_ESSENCE_OF_DANCE) and player:getMainJob() == xi.job.DNC) then
        player:startEvent(10133)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED) then
        player:startEvent(10134)

    -- Dancer AF: Comeback Queen
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM) == QUEST_COMPLETED
        and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN) == QUEST_AVAILABLE
        and player:getMainJob() == xi.job.DNC) then

        player:startEvent(10143)
    elseif (player:getCharVar("comebackQueenCS") == 1) then
        player:startEvent(10144) -- quest chat line after quest accepted Rhea and Olgald have a line as well.
    elseif (player:getCharVar("comebackQueenCS") == 2) then
        player:startEvent(10147)
    elseif (player:getCharVar("comebackQueenCS") == 3 or player:getCharVar("comebackQueenCS") == 6) then
        local currentVanaDay = VanadielDayOfTheYear()
        if (player:getCharVar("comebackQueenDanceOffTimer") < currentVanaDay) then
            player:startEvent(10151)  -- play laila cs 10152->10154  olgald: 1053 if they lose the minigame
        else
            player:startEvent(10140)
        end
    elseif (player:getCharVar("comebackQueenCS") == 4 or player:getCharVar("comebackQueenCS") == 5) then
        player:startEvent(10154) -- This occurs if the player's inventory was full during the final chain of events or if the player speaks with laila afterwards.
    else
        player:startEvent(10120) -- Default
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid== 10129) then
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_COMPLETED) then
            player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ)
            player:delKeyItem(xi.ki.THE_ESSENCE_OF_DANCE)
        end
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ)
        player:setCharVar("QuestStatus_DNC_AF1", 1)

    elseif (csid== 10133) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 19203)
        else
            player:setCharVar("QuestStatus_DNC_AF1", 0)
            player:addItem(19203) -- war hoop
            player:messageSpecial(ID.text.ITEM_OBTAINED, 19203)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ)
        end

    -- Dancer AF: Comeback Queen
    elseif (csid == 10143) then
        player:setCharVar("comebackQueenCS", 1)
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
        player:addKeyItem(xi.ki.WYATTS_PROPOSAL)
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.WYATTS_PROPOSAL)
    elseif (csid == 10147) then
        player:setCharVar("comebackQueenCS", 3)
        local danceOffTimer = VanadielDayOfTheYear()
        player:setCharVar("comebackQueenDanceOffTimer", danceOffTimer)
    elseif (csid == 10151) then --the dance off minigame
        if (option > 0) then -- player won the minigame
            player:startEvent(10208)  -- starts exhausting string of events
        else
            player:setCharVar("comebackQueenCS", 6) -- have surrounding npcs use losing state CS
            local danceOffTimer = VanadielDayOfTheYear()
            player:setCharVar("comebackQueenDanceOffTimer", danceOffTimer)
        end
    elseif (csid == 10208) then
        player:startEvent(10209)
    elseif (csid == 10209) then
        player:startEvent(10210)
    elseif (csid == 10210) then
        player:setCharVar("comebackQueenCS", 4)
        player:startEvent(10211)
    elseif (csid == 10211) then -- finally reward the player
        if (player:getFreeSlotsCount() == 0) then
            -- do nothing. player doesn't have room to receive the reward item.
            player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 14578) -- the names of the gender specific items are the same
        else
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
            player:setCharVar("comebackQueenCS", 5) -- final state for all of the surrounding NPCs
            -- determine what gender the player is so we can give the correct item
            local playerGender = player:getGender()
            local dancersCasaque = 14579 - playerGender

            player:addItem(dancersCasaque)
            player:messageSpecial(ID.text.ITEM_OBTAINED, dancersCasaque)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
        end
    elseif (csid == 10154) then
        if (player:getCharVar("comebackQueenCS") == 4) then -- player's inventory was full at the end of the final cutscene
            if (player:getFreeSlotsCount() == 0) then
                -- do nothing. player doesn't have room to receive the reward item.
                player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 14578) -- the names of the gender specific items are the same
            else
                player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
                player:setCharVar("comebackQueenCS", 5) -- final state for all of the surrounding NPCs
                -- determine what gender the player is so we can give the correct item
                local playerGender = player:getGender()
                local dancersCasaque = 14579 - playerGender

                player:addItem(dancersCasaque)
                player:messageSpecial(ID.text.ITEM_OBTAINED, dancersCasaque)
                player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
            end
        -- the surrounding NPCs should have their dialogue check comebackqueenCS as well.
        end
    end
end

return entity
