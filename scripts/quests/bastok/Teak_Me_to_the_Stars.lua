-----------------------------------
-- Teak Me to the Stars
-----------------------------------
-- Log ID: 1, Quest ID: 79
-- Raibaht : !gotoid 17748012
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TEAK_ME_TO_THE_STARS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    gil = 2100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] = quest:progressEvent(864),

            onEventFinish =
            {
                [864] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.GARHADA_TEAK_LUMBER) then
                        return quest:event(865)
                    end
                end,
            },

            onEventFinish =
            {
                [865] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
