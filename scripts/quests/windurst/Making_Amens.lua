-----------------------------------
-- Making Amens!
-----------------------------------
-- !addquest 2 8
-- Kuroido-Moido : !pos -111 -4 101 240
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS)

quest.reward =
{
    fame     = 150,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.HAKKURU_RINKURUS_BENEFACTOR,
    gil      = 6000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENDS) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
                not player:needToZone()
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:progressEvent(280),

            onEventFinish =
            {
                [280] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.BROKEN_WAND)
        end,

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Mashira'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('hatchOpened') == 0 then
                        return
                    end

                    local rubbishDay =
                        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) == QUEST_ACCEPTED and
                        player:getCharVar("RubbishDayVar") == 0

                    if rubbishDay then
                        return quest:progressEvent(11, 0)
                    else
                        return quest:progressEvent(11, 2)
                    end
                end,
            },

            onEventFinish =
            {
                -- Mashira
                [11] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.BROKEN_WAND)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:event(283):replaceDefault(),
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.BROKEN_WAND)
        end,

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Mashira'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('hatchOpened') == 0 then
                        return
                    end

                    local rubbishDay =
                        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) == QUEST_ACCEPTED and
                        player:getCharVar("RubbishDayVar") == 0

                    if rubbishDay then
                        return quest:progressEvent(11, 0)
                    else
                        return quest:progressEvent(11, 3)
                    end
                end
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:progressEvent(284),

            onEventFinish =
            {
                [284] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:event(286, 0, xi.ki.BROKEN_WAND):importantOnce(),
        },
    },
}

return quest
