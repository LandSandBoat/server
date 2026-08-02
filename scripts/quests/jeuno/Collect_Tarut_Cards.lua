-----------------------------------
-- Collect Tarut Cards
-----------------------------------
-- Log ID: 3, Quest ID: 10
-- Chululu : !pos -13 -6 -42 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS)

quest.reward =
{
    title = xi.title.CARD_COLLECTOR,
}

local tarutCards =
{
    xi.item.TARUT_CARD_THE_FOOL,
    xi.item.TARUT_CARD_DEATH,
    xi.item.TARUT_CARD_THE_HERMIT,
    xi.item.TARUT_CARD_THE_KING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.JEUNO) >= 3
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(28) -- Offers the quest
                end,
            },

            onEventFinish =
            {
                [28] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, { { tarutCards[math.randomInt(1, #tarutCards)], 5 } })
                    then
                        quest:begin(player)
                        quest:setVar(player, 'Date', JstMidnight())
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
                        return quest:progressEvent(200) -- Finishes the quest
                    end
                end,

                onTrigger = function(player, npc)
                    if GetSystemTime() > quest:getVar(player, 'Date') then
                        return quest:progressEvent(10112) -- A new batch of cards, once per Earth day
                    else
                        return quest:progressEvent(27) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [10112] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, { { tarutCards[math.randomInt(1, #tarutCards)], 5 } })
                    then
                        quest:setVar(player, 'Date', JstMidnight())
                    end
                end,

                [200] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 7)
                        player:addFame(xi.fameArea.BASTOK, 7)
                        player:addFame(xi.fameArea.WINDURST, 7)
                        player:tradeComplete()
                    end
                end,
            },
        },
    },
}

return quest
