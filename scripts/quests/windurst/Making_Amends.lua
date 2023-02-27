-----------------------------------
-- Making Amends
-----------------------------------
-- !addquest 2 3
-- Hakkuru-Rinkuru : !pos -111 -4 101 240
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)

quest.reward =
{
    fame     = 75,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.QUICK_FIXER,
    gil      = 1500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:progressEvent(274, 0, xi.items.BLOCK_OF_ANIMAL_GLUE),

            onEventFinish =
            {
                [274] = function(player, csid, option, npc)
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BLOCK_OF_ANIMAL_GLUE) then
                        return quest:event(277, quest.reward.gil)
                    else
                        return quest:event(275, 0, xi.items.BLOCK_OF_ANIMAL_GLUE)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(275, 0, xi.items.BLOCK_OF_ANIMAL_GLUE)
                end,
            },

            ['Kuroido-Moido'] = quest:event(276),

            onEventFinish =
            {
                [277] = function(player, csid, option, npc)
                    player:needToZone(true)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:event(279):importantOnce(),
        },
    },
}

return quest
