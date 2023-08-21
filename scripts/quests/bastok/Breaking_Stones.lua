-----------------------------------
-- Breaking Stones
-----------------------------------
-- Log ID: 1, Quest ID: 10
-- Horatius : !pos -158 -6 -117 235
-- qm2      : !pos -120.041 2.621 415.989 191
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BREAKING_STONES)

quest.reward =
{
    gil      = 400,
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Horatius'] = quest:progressEvent(100),

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
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
            ['Horatius'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.DANGRUF_STONE) then
                        return quest:progressEvent(101)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
