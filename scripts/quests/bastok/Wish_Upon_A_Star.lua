-----------------------------------
-- Wish Upon a Star
-----------------------------------
-- Log ID: 1, Quest ID: 64
-- Enu : !pos -253.673 -13 -92.326 235
-- Malene : !pos -173 -5 64 235
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item = { { xi.items.BAG_OF_CACTUS_STEMS, 4 } }
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
            ['Zacc'] = quest:progressEvent(329),

            ['Malene'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(330)
                    end
                end,
            },

            ['Enu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(332)
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
                    quest:setVar(player, 'Prog', 3)
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
                    if npcUtil.tradeHasExactly(trade, xi.items.FALLEN_STAR) then
                        if
                            (player:getWeather() == xi.weather.NONE or player:getWeather() == xi.weather.SUNSHINE) and
                            (VanadielTOTD() == xi.time.NIGHT or VanadielTOTD() == xi.time.MIDNIGHT)
                        then
                            return quest:progressEvent(334)
                        else
                            return quest:event(337)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [334] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

            },
        },
    },
        -- Section: Completed quest
        {
            check = function(player, status, vars)
                return status == QUEST_COMPLETED
            end,

            [xi.zone.BASTOK_MARKETS] =
            {
                ['Enu'] =
                {
                    onTrigger = function(player, npc)
                        return quest:event(335):replaceDefault()
                    end,
                },
            },
        },
}

return quest
