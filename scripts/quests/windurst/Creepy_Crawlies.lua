-----------------------------------
-- Creepy Crawlies
-----------------------------------
-- Log ID: 2, Quest ID: 39
-- Illu Bohjaa : !pos 21.35 -5 125 241
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES)

quest.reward = -- removed gil reward due to CS having message: using gil = 600 would double the message.
{
    title = xi.title.CRAWLER_CULLER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Illu_Bohjaa'] = quest:event(333, 0, xi.item.SPOOL_OF_SILK_THREAD, xi.item.PAPAKA_GRASS, xi.item.CRAWLER_CALCULUS),

            onEventFinish =
            {
                [333] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Illu_Bohjaa'] = quest:event(334, 0, xi.item.SPOOL_OF_SILK_THREAD, 0, xi.item.CRAWLER_CALCULUS),
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.SPOOL_OF_SILK_THREAD, 3 } }) or
                        npcUtil.tradeHasExactly(trade, { { xi.item.CRAWLER_CALCULUS, 3 } })
                    then
                        return quest:event(335, 600 * xi.settings.main.GIL_RATE, xi.item.SPOOL_OF_SILK_THREAD, 0, xi.item.CRAWLER_CALCULUS)
                    end
                end,
            },

            onEventFinish =
            {
                [335] = function(player, csid, option, npc)
                    if
                        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES) == QUEST_ACCEPTED and
                        quest:complete(player)
                    then
                        player:confirmTrade()
                        player:addGil(600 * xi.settings.main.GIL_RATE) -- moved from reward section due to csid string ID#6549 included message special for gil
                        player:addFame(xi.quest.fame_area.WINDURST, 30)
                    else
                        player:confirmTrade()
                        player:addGil(600 * xi.settings.main.GIL_RATE) -- moved from reward section due to csid string ID#6549 included message special for gil
                        player:addFame(xi.quest.fame_area.WINDURST, 15)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Illu_Bohjaa'] = quest:event(336):replaceDefault(),
        },
    },
}

return quest
