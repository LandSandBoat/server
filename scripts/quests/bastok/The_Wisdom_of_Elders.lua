-----------------------------------
-- The Wisdom of Elders
-----------------------------------
-- Log ID: 1, Quest ID: 36
-- Benita : !pos 49.692 -4.771 36.189 236
-- Tete   : !pos 15.249 -2.097 43.012 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.TRAVELERS_HAT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Benita'] = quest:progressEvent(174),

            onEventFinish =
            {
                [174] = function(player, csid, option, npc)
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
            ['Benita'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.PINCH_OF_BOMB_ASH) then
                        return quest:progressEvent(176)
                    end
                end,
            },

            ['Tete'] = quest:event(175):importantOnce(),

            onEventFinish =
            {
                [175] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [176] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
