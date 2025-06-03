-----------------------------------
-- Area: Western Adoulin
--  NPC: Westerly Breeze
-- !pos 62 32 123 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local amqtr = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)

    if trade:getItemCount() == 1 and trade:getGil() == 0 then
        local item = trade:getItem(0)
        if not item then
            return
        end

        local itemId = item:getID()
        local ahCategory = item:getAHCat()

        if ahCategory >= 52 and ahCategory <= 57 then
            -- We traded him a food item
            if
                player:getCharVar('ATWTTB_Can_Trade_Gruel') == 1 and
                (itemId == 4489 or itemId == 4534)
            then
                if itemId == 4489 then
                    -- Trading him Vegetable Gruel after completing Quest: 'All The Way To The Bank'
                    player:startEvent(5068)
                elseif itemId == 4534 then
                    -- Trading him Medicinal Gruel after completing Quest: 'All The Way To The Bank'
                    player:startEvent(5068, 1)
                end
            end
        elseif ahCategory == 58 then
            if amqtr == xi.questStatus.QUEST_ACCEPTED then
                if itemId == 4541 then
                    -- We gave him another Goblin Drink.
                    -- Special event where he refuses it.
                    player:startEvent(3013)
                else
                    -- Special event where he drinks a non-goblin drink.
                    player:startEvent(3014)
                end
            end
        else
            if itemId == 4234 and amqtr == xi.questStatus.QUEST_ACCEPTED then
                -- We gave him Cursed Beverage.
                -- Finishes Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3012)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local amqtr = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)

    if
        player:getFameLevel(xi.fameArea.ADOULIN) >= 2 and
        not player:needToZone() and VanadielUniqueDay() > player:getCharVar('Westerly_Breeze_Wait')
    then
        if
            amqtr ~= xi.questStatus.QUEST_COMPLETED and
            player:getFameLevel(xi.fameArea.ADOULIN) >= 3
        then
            if amqtr == xi.questStatus.QUEST_AVAILABLE then
                -- Starts Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3010)
            else
                -- Reminder for Quest: 'Always More Quoth the Ravenous'
                player:startEvent(3011)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3010 then
        -- Starting Quest: 'Always More Quoth the Ravenous'
        player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)
    elseif csid == 3012 then
        -- Finishing Quest: 'Always More Quoth The Ravenous'
        player:tradeComplete()
        player:completeQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.ALWAYS_MORE_QUOTH_THE_RAVENOUS)
        player:addExp(1500 * xi.settings.main.EXP_RATE)
        player:addCurrency('bayld', 1000 * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 1000 * xi.settings.main.BAYLD_RATE)

        -- TODO: Verify fame value added
        player:addFame(xi.fameArea.ADOULIN, 30)
        player:setCharVar('Westerly_Breeze_Wait', 0)
    elseif csid == 3014 then
        -- Consuming wrong food item given to him during his quests
        player:tradeComplete()
    elseif csid == 5068 then
        -- Trading him gruel after Quest: 'All The Way To The Bank'
        player:tradeComplete()
        local gilObtained = 19716
        if option == 1 then
            gilObtained = 39432
        end

        npcUtil.giveCurrency(player, 'gil', gilObtained)
        player:setCharVar('ATWTTB_Can_Trade_Gruel', 0)
    end
end

return entity
