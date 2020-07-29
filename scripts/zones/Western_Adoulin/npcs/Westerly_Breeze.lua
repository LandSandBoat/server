-----------------------------------
-- Area: Western Adoulin
--  NPC: Westerly Breeze
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quests: 'Hunger Strikes'
--                                             'The Starving'
--                                             'Always More, Quoth the Ravenous'
-- !pos 62 32 123 256
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local HS = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.HUNGER_STRIKES)
    local TS = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.THE_STARVING)
    local AMQTR = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)

    if ((trade:getItemCount() == 1) and (trade:getGil() == 0)) then
        local item = trade:getItem(0)
        local item_ID = item:getID()
        local AH_Category = item:getAHCat()
        if (AH_Category >= 52) and (AH_Category <= 57) then
            -- We traded him a food item
            if ((player:getCharVar("ATWTTB_Can_Trade_Gruel") == 1) and ((item_ID == 4489) or (item_ID == 4534))) then
                if (item_ID == 4489) then
                    -- Trading him Vegetable Gruel after completing Quest: 'All The Way To The Bank'
                    player:startEvent(5068)
                elseif (item_ID == 4534) then
                    -- Trading him Medicinal Gruel after completing Quest: 'All The Way To The Bank'
                    player:startEvent(5068, 1)
                end
            elseif (HS == QUEST_ACCEPTED) then
                if (item_ID == 4592) then
                    -- We gave him Wisdom Soup.
                    -- Finishes Quest: 'Hunger Strikes'.
                    player:startEvent(2532)
                else
                    -- Special event where he consumes the food item despite it being wrong.
                    player:startEvent(2533)
                end
            end
        elseif (AH_Category == 58) then
            -- We traded him a drink.
            if (TS == QUEST_ACCEPTED) then
                if (item_ID == 4541) then
                    -- We gave him Goblin Drink.
                    -- Finishes Quest: 'The Starving'.
                    player:startEvent(3007)
                else
                    -- Special event where he drinks a non-goblin drink.
                    player:startEvent(3008)
                end
            elseif (AMQTR == QUEST_ACCEPTED) then
                if (item_ID == 4541) then
                    -- We gave him another Goblin Drink.
                    -- Special event where he refuses it.
                    player:startEvent(3013)
                else
                    -- Special event where he drinks a non-goblin drink.
                    player:startEvent(3014)
                end
            end
        else
            if ((item_ID == 4234) and (AMQTR == QUEST_ACCEPTED)) then
                -- We gave him Cursed Beverage.
                -- Finishes Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3012)
            end
        end
    end
end

function onTrigger(player, npc)
    local HS = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.HUNGER_STRIKES)
    local TS = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.THE_STARVING)
    local AMQTR = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)
    if (HS ~= QUEST_COMPLETED) then
        if (HS == QUEST_AVAILABLE) then
            -- Starts Quest: 'Hunger Strikes'
            player:startEvent(2530)
        else
            -- Reminder for Quest: 'Hunger Strikes'
            player:startEvent(2531)
        end
    elseif ((player:getFame(ADOULIN) >= 2) and (not player:needToZone()) and (vanaDay() > player:getCharVar("Westerly_Breeze_Wait"))) then
        if (TS ~= QUEST_COMPLETED) then
            if (TS == QUEST_AVAILABLE) then
                -- Starts Quest: 'The Starving'
                player:startEvent(3005)
            else
                -- Reminder for Quest: 'The Starving'
                player:startEvent(3006)
            end
        elseif ((AMQTR ~= QUEST_COMPLETED) and (player:getFame(ADOULIN) >= 3)) then
            if (AMQTR == QUEST_AVAILABLE) then
                -- Starts Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3010)
            else
                -- Reminder for Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3011)
            end
        else
            -- Standard dialogue
            player:startEvent(553)
        end
    else
        -- Standard dialogue
        player:startEvent(553)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2530) then
        -- Starting Quest: 'Hunger Strikes'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.HUNGER_STRIKES)
    elseif ((csid == 2532) or (csid == 3007)) then
        -- Finishing Quest: 'Hunger Strikes' or 'The Starving'
        player:tradeComplete()
        player:addExp(1000 * EXP_RATE)
        player:addCurrency('bayld', 500 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 500 * BAYLD_RATE)
        player:addFame(ADOULIN)
        player:setCharVar("Westerly_Breeze_Wait", vanaDay())
        player:needToZone(true)

        if (csid == 2532) then
            player:completeQuest(ADOULIN, tpz.quest.id.adoulin.HUNGER_STRIKES)
        elseif (csid == 3007) then
            player:completeQuest(ADOULIN, tpz.quest.id.adoulin.THE_STARVING)
        end
    elseif (csid == 3005) then
        -- Starting Quest: 'The Starving'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.THE_STARVING)
    elseif (csid == 3010) then
        -- Starting Quest: 'Always More Quoth the Ravenous'
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)
    elseif (csid == 3012) then
        -- Finishing Quest: 'Always More Quoth The Ravenous'
        player:tradeComplete()
        player:completeQuest(ADOULIN, tpz.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)
        player:addExp(1500 * EXP_RATE)
        player:addCurrency('bayld', 1000 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 1000 * BAYLD_RATE)
        player:addFame(ADOULIN)
        player:setCharVar("Westerly_Breeze_Wait", 0)
    elseif ((csid == 2533) or (csid == 3008) or (csid == 3014)) then
        -- Consuming wrong food item given to him during his quests
        player:tradeComplete()
    elseif (csid == 5068) then
        -- Trading him gruel after Quest: 'All The Way To The Bank'
        player:tradeComplete()
        local gil_obtained = 0
        if (option == 1) then
            gil_obtained = 39432 * GIL_RATE
        else
            gil_obtained = 19716 * GIL_RATE
        end
        player:addGil(gil_obtained)
        player:messageSpecial(ID.text.GIL_OBTAINED, gil_obtained)
        player:setCharVar("ATWTTB_Can_Trade_Gruel", 0)
    end
end
