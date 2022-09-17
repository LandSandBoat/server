-----------------------------------
-- All at Sea
-----------------------------------
-- !addquest 2 23
-- Paytah !pos
-- Baren-Moren !pos
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ALL_AT_SEA)

quest.reward =
{
    xp = 2000,
    fame = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    keyItem = xi.ki.MAP_OF_THE_HORUTOTO_RUINS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] = quest:progressEvent(291),

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(291)
                end,

                onTrade = function(player, npc, trade)
                end,
            },

            onEventFinish =
            {
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Baren-Moren'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(291)
                end,

                onTrade = function(player, npc, trade)
                end,
            },

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
}

return quest
