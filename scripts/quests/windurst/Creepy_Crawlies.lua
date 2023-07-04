-----------------------------------
-- Creepy Crawlies
-----------------------------------
-- Log ID: 2, Quest ID: 39
-- Illu Bohjaa : !pos 21.35 -5 125 241
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES)

quest.reward =
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
            ['Illu_Bohjaa'] = quest:event(333, 0, xi.items.SPOOL_OF_SILK_THREAD, xi.items.PAPAKA_GRASS, xi.items.CRAWLER_CALCULUS),

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
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Illu_Bohjaa'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.items.SPOOL_OF_SILK_THREAD, 3 } }) then
                        player:addFame(xi.quest.fame_area.WINDURST, 15)
                        return quest:event(335, 600, xi.items.SPOOL_OF_SILK_THREAD, 0, xi.items.CRAWLER_CALCULUS)
                    elseif npcUtil.tradeHas(trade, { { xi.items.CRAWLER_CALCULUS, 3 } }) then
                        player:addFame(xi.quest.fame_area.WINDURST, 30)
                        return quest:event(335, 600, xi.items.SPOOL_OF_SILK_THREAD, 0, xi.items.CRAWLER_CALCULUS)
                    end
                end,

                onTrigger = quest:event(334, 0, xi.items.SPOOL_OF_SILK_THREAD, 0, xi.items.CRAWLER_CALCULUS),
            },

            onEventFinish =
            {
                [335] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(600 * xi.settings.main.GIL_RATE) -- moved from reward section due to csis string ID#6549 included message special for gil

                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CREEPY_CRAWLIES) == QUEST_ACCEPTED then
                        quest:complete(player)
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
            ['Illu_Bohjaa'] =
            {
                onTrigger = quest:event(336):replaceDefault(),

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.items.SPOOL_OF_SILK_THREAD, 3 } }) then
                        player:addFame(xi.quest.fame_area.WINDURST, 15)
                        player:confirmTrade()
                        player:addGil(600 * xi.settings.main.GIL_RATE) -- moved from reward section due to csis string ID#6549 included message special for gil
                        return quest:event(335, 600, xi.items.SPOOL_OF_SILK_THREAD, 0, xi.items.CRAWLER_CALCULUS)
                    elseif npcUtil.tradeHas(trade, { { xi.items.CRAWLER_CALCULUS, 3 } }) then
                        player:addFame(xi.quest.fame_area.WINDURST, 30)
                        player:confirmTrade()
                        player:addGil(600 * xi.settings.main.GIL_RATE) -- moved from reward section due to csis string ID#6549 included message special for gil
                        return quest:event(335, 600, xi.items.SPOOL_OF_SILK_THREAD, 0, xi.items.CRAWLER_CALCULUS)
                    end
                end,
            },
        },
    },
}

return quest
