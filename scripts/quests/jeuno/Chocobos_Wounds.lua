-----------------------------------
-- Chocobo's Wounds
-----------------------------------
-- Log ID: 3, Quest ID: 4
-- Brutus  : !pos -55 8 95 244
-- Chocobo : !pos -61.42 8.2 93 244
-- Osker   : !pos -61.42 8.2 94.2 244
-- _6t2    : !pos -88.2 -7.65 -168.8 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    keyItem  = xi.ki.CHOCOBO_LICENSE,
    title    = xi.title.CHOCOBO_TRAINER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:getMainLvl() >= 20
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] = quest:event(64),
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    local declinedOption = quest:getVar(player, 'Declined') == 1 and 0 or 1
                    return quest:progressEvent(71, declinedOption)
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)

                    -- Dialogue changes if the player fails to choose the correct option.
                    else
                        quest:setVar(player, 'Declined', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') > 3 then
                        return quest:event(63)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:event(65)
                    elseif questProgress == 2 then
                        return quest:event(66)
                    else
                        return quest:event(102)
                    end
                end,
            },

            ['Chocobo'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.BUNCH_OF_GYSAHL_GREENS) > 0 then
                        return quest:event(76)
                    end

                    if trade:getItemQty(xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS) == 0 then
                        return quest:noAction()
                    end

                    if quest:getVar(player, 'Timer') > GetSystemTime() then
                        return quest:event(73)
                    end

                    local eventTable =
                    {
                        [1] = 57,
                        [2] = 58,
                        [3] = 99,
                        [4] = 59,
                        [5] = 60,
                        [6] = 64,
                    }

                    local questProgress = quest:getVar(player, 'Prog')
                    if questProgress <= 2 then
                        return quest:progressEvent(eventTable[questProgress])
                    end

                    if npcUtil.tradeHasExactly(trade, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS) then
                        return quest:progressEvent(eventTable[questProgress])
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(62)
                    else
                        return quest:event(63)
                    end
                end,
            },

            ['Osker'] =
            {
                onTrigger = function(player, npc)
                    local eventTable =
                    {
                        [1] = 103,
                        [2] = 51,
                        [3] = 52,
                        [4] = 49,
                        [5] = 46,
                        [6] = 47,
                    }

                    return quest:event(eventTable[quest:getVar(player, 'Prog')])
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Timer', GetSystemTime() + 45)
                end,

                [58] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Timer', GetSystemTime() + 45)
                end,

                [59] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    quest:setVar(player, 'Timer', GetSystemTime() + 45)
                    player:confirmTrade()
                end,

                [60] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                    quest:setVar(player, 'Timer', GetSystemTime() + 45)
                    player:confirmTrade()
                end,

                [64] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [99] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, 'Timer', GetSystemTime() + 45)
                    player:confirmTrade()
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus' ] = quest:event(22), -- Always used except for importantOnce() for Chocobo on the Loose (10094)
            ['Chocobo'] = quest:event(61),
            ['Osker'  ] = quest:event(53),
        },
    },
}

return quest
