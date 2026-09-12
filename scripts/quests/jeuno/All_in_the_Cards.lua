-----------------------------------
-- All in the Cards
-----------------------------------
-- Log ID: 3, Quest ID: 166
-- Chululu : !pos -13 -6 -42 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.ALL_IN_THE_CARDS)

quest.reward =
{
    gil   = 600,
    title = xi.title.CARD_COLLECTOR,
}

local tarutCards =
{
    xi.item.TARUT_CARD_THE_FOOL,
    xi.item.TARUT_CARD_DEATH,
    xi.item.TARUT_CARD_THE_HERMIT,
    xi.item.TARUT_CARD_THE_KING,
}

local function giveCards(player)
    if npcUtil.giveItem(player, { { tarutCards[math.randomInt(1, #tarutCards)], 5 } }) then
        quest:setVar(player, 'Date', JstMidnight())
        return true
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS) == xi.questStatus.QUEST_COMPLETED and
                GetSystemTime() > quest:getVar(player, 'Date')
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10110) -- Offers the quest
                end,
            },

            onEventFinish =
            {
                [10110] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        giveCards(player)
                    then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS) == xi.questStatus.QUEST_COMPLETED and
                GetSystemTime() > quest:getVar(player, 'Date')
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10113) -- Offers the quest again
                end,
            },

            onEventFinish =
            {
                [10113] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        giveCards(player)
                    then
                        quest:begin(player)
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
            ['Chululu'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.TARUT_CARD_THE_FOOL, 1 }, { xi.item.TARUT_CARD_DEATH, 1 }, { xi.item.TARUT_CARD_THE_HERMIT, 1 }, { xi.item.TARUT_CARD_THE_KING, 1 } }) then
                        return quest:progressEvent(10114) -- Finishes the quest
                    end
                end,

                onTrigger = function(player, npc)
                    if GetSystemTime() > quest:getVar(player, 'Date') then
                        return quest:event(10112) -- A new batch of cards, once per Earth day
                    else
                        return quest:event(10111) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [10112] = function(player, csid, option, npc)
                    giveCards(player)
                end,

                [10114] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 16)
                        player:addFame(xi.fameArea.BASTOK, 16)
                        player:addFame(xi.fameArea.WINDURST, 16)
                        player:tradeComplete()
                        quest:setVar(player, 'Date', JstMidnight()) -- Next offer waits for JST midnight
                    end
                end,
            },
        },
    },
}

return quest
