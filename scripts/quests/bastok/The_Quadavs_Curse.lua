-----------------------------------
-- The Quadav's Curse
-----------------------------------
-- Log ID: 1, Quest ID: 4
-- Corann : !pos 90.935 -8.772 32.564 236
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_QUADAVS_CURSE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.BRONZE_SUBLIGAR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Corann'] = quest:progressEvent(80),

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Corann'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.QUADAV_BACKPLATE) then
                        return quest:progressEvent(81)
                    end
                end,
            },

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_ONES_SHELL)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Corann'] = quest:event(87):replaceDefault(),
        },
    },
}

return quest
