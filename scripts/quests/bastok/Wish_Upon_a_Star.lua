-----------------------------------
-- Wish Upon a Star
-----------------------------------
-- Log ID: 1, Quest ID: 64
-- Zacc   : !pos -255.709 -13 -91.379 235
-- Malene : !pos -173 -5 64 235
-- Enu    : !pos -253.673 -13 -92.326 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR)

quest.reward =
{
    fame     = 50,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = { { xi.item.BAG_OF_CACTUS_STEMS, 4 } },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 5
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Enu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(332)
                    end
                end,
            },

            ['Malene'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(330)
                    end
                end,
            },

            ['Zacc'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(329)
                    end
                end,
            },

            onEventFinish =
            {
                [329] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [330] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [332] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Enu'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.FALLEN_STAR) then
                        local isNight = VanadielTOTD() == xi.time.NIGHT or VanadielTOTD() == xi.time.MIDNIGHT

                        if
                            player:getWeather() == xi.weather.NONE and
                            isNight
                        then
                            return quest:progressEvent(334)
                        else
                            return quest:event(337)
                        end
                    end
                end,

                onTrigger = quest:event(333),
            },

            onEventFinish =
            {
                [334] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Enu']  = quest:event(335):replaceDefault(),
            ['Zacc'] = quest:event(336):replaceDefault(),
        },
    }
}

return quest
