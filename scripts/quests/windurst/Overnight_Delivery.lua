-----------------------------------
-- Overnight Delivery
-----------------------------------
-- !addquest 2 15
-- Kenapa-Keppa  : !pos 27 -6 -199 238
-- Kotan-Purutan : !pos 40.32 -9 44.24 249
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)

quest.reward =
{
    fame = 100,
    fameArea = xi.quest.fame_area.WINDURST,
    item = xi.item.POWER_GI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 and
                player:getLocalVar('Quest[2][14]mustZone') == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local vanadielHour = VanadielHour()

                    -- Player has previously failed this quest
                    if questProgress == 256 then
                        return quest:progressEvent(347)

                    -- Quest Available Pattern (First attempt and previously failed)
                    elseif vanadielHour >= 7 and vanadielHour < 24 then
                        if questProgress == 0 then
                            return quest:progressEvent(336)
                        elseif questProgress == 1 then
                            return quest:progressEvent(337)
                        elseif questProgress == 2 then
                            return quest:progressEvent(338)
                        elseif questProgress == 3 then
                            return quest:progressEvent(339)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [336] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [337] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [338] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [339] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 4)
                    else
                        quest:setVar(player, 'Prog', 0)
                    end
                end,

                [347] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Kotan-Purutan'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        not player:hasKeyItem(xi.ki.SMALL_BAG) and
                        questProgress >= 4 and
                        questProgress <= 7
                    then
                        local vanadielHour  = VanadielHour()

                        if vanadielHour < 6 or vanadielHour >= 18 then
                            return quest:progressEvent(141)
                        else
                            return quest:progressEvent(144)
                        end
                    else
                        return quest:progressEvent(142)
                    end
                end,
            },

            onEventFinish =
            {
                [141] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SMALL_BAG)

                    -- Track timing by day in which the KI is due to be delivered in order
                    -- to simplify the logic for completing this quest.
                    if VanadielHour() < 6 then
                        quest:setVar(player, 'dueDate', VanadielUniqueDay())
                    else
                        quest:setVar(player, 'dueDate', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SMALL_BAG) then
                        local dueDate = quest:getVar(player, 'dueDate')
                        local currentDay = VanadielUniqueDay()

                        if
                            dueDate > currentDay or
                            (dueDate == currentDay and VanadielHour() < 6)
                        then
                            return quest:progressEvent(348)
                        else
                            return quest:progressEvent(346)
                        end
                    else
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 4 then
                            return quest:progressEvent(340)
                        elseif questProgress == 5 then
                            return quest:progressEvent(341)
                        elseif questProgress == 6 then
                            return quest:progressEvent(342)
                        elseif questProgress == 7 then
                            return quest:progressEvent(343)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                -- Kenapa-Keppa's reminder text cycles.  Events 340~343 loop
                -- through the available messages.
                [340] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [341] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [342] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,

                [343] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [346] = function(player, csid, option, npc)
                    player:delQuest(quest.areaId, quest.questId)
                    player:delKeyItem(xi.ki.SMALL_BAG)
                    quest:setVar('dueDate', 0)
                    quest:setVar(player, 'Prog', 256)
                end,

                [348] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SMALL_BAG)
                        player:setLocalVar('Quest[2][16]mustZone', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Kotan-Purutan'] = quest:event(143):replaceDefault(),

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.quest.fame_area.WINDURST) < 6 then
                        return quest:event(351):replaceDefault()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    if math.random(1, 2) == 1 then
                        return quest:event(349):replaceDefault()
                    else
                        return quest:event(350):replaceDefault()
                    end
                end,
            },
        },
    },
}

return quest
