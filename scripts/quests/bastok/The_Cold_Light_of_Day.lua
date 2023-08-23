-----------------------------------
-- The Cold Light of Day
-----------------------------------
-- Log ID: 1, Quest ID: 11
-- Malene : !pos -173 -5 64 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Malene'] = quest:progressEvent(102),

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gwill'] = quest:event(103),

            ['Malene'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.STEAM_CLOCK) then
                        return quest:progressEvent(104)
                    end
                end,

                onTrigger = quest:event(102),
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
