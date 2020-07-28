-----------------------------------
-- Area: Upper Jeuno
--   NPC: Laila
-- Type: Job Quest Giver
-- !pos -54.045 -1 100.996 244
--
--TODO--
-- make sure the surrounding npcs react to the player accordingly after each quest. There are a few event IDs that I don't recall using
-- make global variables for all these event hexvalues and put them in textids
--TODO--
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local lakesideMin = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LAKESIDE_MINUET)
    local lakeProg = player:getCharVar("Lakeside_Minuet_Progress")
    if (lakesideMin == QUEST_AVAILABLE and player:getMainLvl() >= ADVANCED_JOB_LEVEL and ENABLE_WOTG == 1) then
        player:startEvent(10111) -- Start quest csid, asks for Key Item Stardust Pebble
    elseif (lakesideMin == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(10119)
    elseif (player:hasKeyItem(tpz.ki.STARDUST_PEBBLE)) then
        player:startEvent(10118) -- Ends Quest
    elseif (lakeProg == 3) then
        player:startEvent(10113)
    elseif (lakesideMin == QUEST_ACCEPTED) then
        player:startEvent(10112) -- After accepting, reminder
    elseif ((player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_AVAILABLE
        or (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_COMPLETED
        and player:hasItem(19203) == false))
        and player:getMainJob() == tpz.job.DNC and player:getMainLvl()>=40) then

        player:startEvent(10129)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1") == 5 and player:seenKeyItem(tpz.ki.THE_ESSENCE_OF_DANCE) and player:getMainJob() == tpz.job.DNC) then
        player:startEvent(10133)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED) then
        player:startEvent(10134)

    -- Dancer AF: The Road to Divadom
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_COMPLETED
        and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM) == QUEST_AVAILABLE
        and player:getMainJob() == tpz.job.DNC) then

        player:startEvent(10136) -- CSID 10136
    elseif (player:getCharVar("roadToDivadomCS") == 1) then
        player:startEvent(10137) --  quest chat line after the quest has been accepted
    elseif (player:getCharVar("roadToDivadomCS") == 4) then
        player:startEvent(10139) --CSID 10139
    elseif (player:getCharVar("roadToDivadomCS") == 5) then
        player:startEvent(10170) --CSID 10170. This should only occur if the player's inventory was full during the chain of events that start in the elseif above.

    -- Dancer AF: Comeback Queen
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM) == QUEST_COMPLETED
        and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN) == QUEST_AVAILABLE
        and player:getMainJob() == tpz.job.DNC) then

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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10111 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.LAKESIDE_MINUET)
    elseif (csid == 10118) then
        player:setCharVar("Lakeside_Minuet_Progress", 0)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.LAKESIDE_MINUET)
        player:addTitle(tpz.title.TROUPE_BRILIOTH_DANCER)
        player:unlockJob(tpz.job.DNC)
        player:messageSpecial(ID.text.UNLOCK_DANCER)
        player:addFame(JEUNO, 30)
        player:delKeyItem(tpz.ki.STARDUST_PEBBLE)
        player:needToZone(true)
    elseif (csid== 10129) then
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_COMPLETED) then
            player:delQuest(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ)
            player:delKeyItem(tpz.ki.THE_ESSENCE_OF_DANCE)
        end
        player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ)
        player:setCharVar("QuestStatus_DNC_AF1", 1)

    elseif (csid== 10133) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 19203)
        else
            player:setCharVar("QuestStatus_DNC_AF1", 0)
            player:addItem(19203) -- war hoop
            player:messageSpecial(ID.text.ITEM_OBTAINED, 19203)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ)
        end

    -- Dancer AF: The Road to Divadom
    elseif (csid == 10136) then -- Road To Divadom pt 1
        player:setCharVar("roadToDivadomCS", 1)
        player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM)
    elseif (csid == 10139) then -- string of events
        player:startEvent(10214)
    elseif (csid == 10214) then
        player:startEvent(10215)
    elseif (csid == 10215) then
        player:setCharVar("roadToDivadomCS", 5)
        player:startEvent(10170)
    elseif (csid == 10170) then
        if (player:getFreeSlotsCount() == 0) then
            -- do nothing. player doesn't have room to receive the reward item.
            player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 15660) -- the names of the gender specific items are the same
        else
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM)
            player:setCharVar("roadToDivadomCS", 0)
            player:setCharVar("dancerTailorCS", 1) -- allows player to start dancer version of Coffer AF. check Olgald and Matthias(@Bastok Markets) for the rest of the quest line
            -- determine what gender the player is so we can give the correct item
            local playerGender = player:getGender()
            local dancersTights = 15660 - playerGender

            player:addItem(dancersTights)
            player:messageSpecial(ID.text.ITEM_OBTAINED, dancersTights)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM)
            end
    -- Dancer AF: Comeback Queen
    elseif (csid == 10143) then
        player:setCharVar("comebackQueenCS", 1)
        player:addQuest(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN)
        player:addKeyItem(tpz.ki.WYATTS_PROPOSAL)
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.WYATTS_PROPOSAL)
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
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN)
            player:setCharVar("comebackQueenCS", 5) -- final state for all of the surrounding NPCs
            -- determine what gender the player is so we can give the correct item
            local playerGender = player:getGender()
            local dancersCasaque = 14579 - playerGender

            player:addItem(dancersCasaque)
            player:messageSpecial(ID.text.ITEM_OBTAINED, dancersCasaque)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN)
        end
    elseif (csid == 10154) then
        if (player:getCharVar("comebackQueenCS") == 4) then -- player's inventory was full at the end of the final cutscene
            if (player:getFreeSlotsCount() == 0) then
                -- do nothing. player doesn't have room to receive the reward item.
                player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 14578) -- the names of the gender specific items are the same
            else
                player:completeQuest(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN)
                player:setCharVar("comebackQueenCS", 5) -- final state for all of the surrounding NPCs
                -- determine what gender the player is so we can give the correct item
                local playerGender = player:getGender()
                local dancersCasaque = 14579 - playerGender

                player:addItem(dancersCasaque)
                player:messageSpecial(ID.text.ITEM_OBTAINED, dancersCasaque)
                player:completeQuest(JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN)
            end
        -- the surrounding NPCs should have their dialogue check comebackqueenCS as well.
        end
    end
end
