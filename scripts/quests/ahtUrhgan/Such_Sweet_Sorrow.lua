-----------------------------------
-- Such Sweet Sorrow
-----------------------------------
-- Log ID: 6, Quest ID: 13
-- Dabhuh: !pos 97.939 0 -91.530 50
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
require("scripts/globals/zone")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SUCH_SWEET_SORROW)

quest.reward =
{
    item = xi.items.MERROW_NO_17_LOCKET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dabhuh'] = quest:progressEvent(582, { text_table = 0 }),

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Option') == 2 then
                        return { 956, 0 }
                    end
                end,
            },

            onEventFinish =
            {
                [582] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                    player:setPos(43.493, 5.325, -699.828, 90, xi.zone.CAEDARVA_MIRE)
                end,

                [956] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Option') == 1 then
                        return 29
                    end
                end
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 2)
                    player:setPos(100.023, 0, -91.762, 125, xi.zone.AHT_URHGAN_WHITEGATE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dabhuh'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(584, { text_table = 0 })
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.MERROW_SCALE }) then
                        return quest:progressEvent(583, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [583] = function(player, csid, option, npc)
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

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dabhuh'] = quest:event(584, { text_table = 0 }),
        },
    },
}

return quest
