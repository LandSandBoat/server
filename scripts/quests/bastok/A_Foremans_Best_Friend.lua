-----------------------------------
-- A Foreman's Best Friend
-----------------------------------
-- Log ID: 1, Quest ID: 9
-- Gudav : !pos -3.286 1.407 50.591 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FOREMANS_BEST_FRIEND)

quest.reward =
{
    exp      = 2000,
    fame     = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    keyItem  = xi.ki.MAP_OF_THE_GUSGEN_MINES,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Gudav'] = quest:progressEvent(110),

            onEventFinish =
            {
                [110] = function(player, csid, option, npc)
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
            ['Dehlner'] = quest:event(111),

            ['Gudav'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.DOG_COLLAR) then
                        return quest:progressEvent(112)
                    end
                end,
            },

            onEventFinish =
            {
                [112] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
