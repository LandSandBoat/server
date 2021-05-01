-----------------------------------
-- Delivering the Goods
-- Fochacha, Whitegate , !pos 3 -1 -10.781 50
-- Qutiba, Whitegate, !pos 92 -7.5 -130 50
-- Ulamaal, Whitegate, !pos 93 -7.5 -128 50
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.DELIVERING_THE_GOODS)

quest.reward = {
    item = {{xi.items.IMPERIAL_BRONZE_PIECE, 3}}
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Fochacha'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(39)
                end,
            },
            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(51)
                end,
            },
            ['Ulamaal'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(51)
                end,
            },

            onEventFinish = {
                [39] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },
            ['Ulamaal'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },

            onEventFinish = {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Fochacha'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(41)
                end,
            },
            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(52)
                end,
            },
            ['Ulamaal'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(53)
                end,
            },

            onEventFinish = {
                [41] = function(player, csid, option, npc)
                    player:setVar("Quest[6][62]Stage", getMidnight())
                    player:needToZone(true)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
