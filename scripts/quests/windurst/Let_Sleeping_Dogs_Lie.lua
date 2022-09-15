-----------------------------------
-- Let Sleeping Dogs Die
-----------------------------------
-- !addquest 2 46
-- Mashuu-Ajuu 130 -5 167
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)

quest.reward =
{
    item = xi.items.HYPNO_STAFF,
    fame = 75,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
            not player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Paku-Nakku'] = quest:progressEvent(481),

            onEventFinish =
            {
                [481] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] = quest:progressEvent(483),
            ['Akkeke'] = quest:progressEvent(484),
            ['Kirara'] = quest:progressEvent(485),
            ['Rukuku'] = quest:progressEvent(487),
            ['Koko Lihzeh'] = quest:progressEvent(488),
            ['Chomoro-Kyotoro'] = quest:progressEvent(489),
            ['Paku-Nakku'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(494, 653393087, 1, 0, 1200, 8388608, 3749, 4095, 2) -- 0, 0, 0, 0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(499)
                    else
                        return quest:progressEvent(482)
                    end
                end,
            },
            ['Pechiru-Mashiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(495, 4155, 1102, 1, 50617851, 2729760, 0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(496)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(497)
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
                [495] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
                [497] = function(player, csid, option, npc)
                    quest:completeQuest(player)
                end,
                [499] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Maabu-Sonbu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(319, 653392653, 4155, 1102, 1020) -- 0, 0, 0, 0)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(321, 653393447, 1102, 0, 0, 67108863, 41513848, 4095, 4)
                    else
                        return quest:progressEvent(320, 653392653, 4155, 1102) -- 1020, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HAT_IN_HAND) ~= QUEST_ACCEPTED then
                        quest:progressEvent(498)
                    end
                end,
            },
        }
    },
}

return quest
