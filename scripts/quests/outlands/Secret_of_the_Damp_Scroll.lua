-----------------------------------
-- Secret of the Damp Scroll
-----------------------------------
-- Log ID: 5, Quest ID: 135
-- Shivivi     : !pos 68.729 -6.281 -6.432 252
-- Hot Springs : !pos 444 -37 -18 139
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)

quest.reward =
{
    fame     = 75,
    fameArea = xi.quest.fame_area.NORG,
    item     = xi.item.SCROLL_OF_JUBAKU_ICHI,
    title    = xi.title.CRACKER_OF_THE_SECRET_CODE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.NORG) >= 3 and
                player:getMainLvl() >= 10 and
                player:hasItem(xi.item.DAMP_SCROLL)
        end,

        [xi.zone.NORG] =
        {
            ['Shivivi'] = quest:progressEvent(31, xi.item.DAMP_SCROLL),

            onEventFinish =
            {
                [31] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Shivivi'] = quest:event(32),
        },

        [xi.zone.HORLAIS_PEAK] =
        {
            ['Hot_Springs'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.DAMP_SCROLL) then
                        return quest:progressEvent(2, xi.item.DAMP_SCROLL)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
