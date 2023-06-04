-----------------------------------
-- Save My Son
-----------------------------------
-- Log ID: 3, Quest ID: 5
-- Door: Merchant's House (_6t2) : !pos -82.22 -7.65 -168.839 245
-- Nightflowers                  : !pos -264.775 -3.718 28.767 126
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 2100,
    item     = xi.items.BEAST_WHISTLE,
    title    = xi.title.LIFE_SAVER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS) and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] = quest:progressEvent(164),

            onEventFinish =
            {
                [164] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(163)
                    else
                        return quest:event(229)
                    end
                end,
            },

            onEventFinish =
            {
                [163] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Shalott'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(101)
                    else
                        return quest:event(44)
                    end
                end,
            },
        },

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Nightflowers'] =
            {
                onTrigger = function(player, npc)
                    local vanadielClockTime = utils.vanadielClockTime()

                    if
                        quest:getVar(player, 'Prog') == 0 and
                        (
                            vanadielClockTime > 2130 or
                            vanadielClockTime <= 540
                        )
                    then
                        return quest:progressEvent(0)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] = quest:event(132):replaceDefault(),
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Shalott'] = quest:event(44):replaceDefault(),
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Chocobo'] = quest:event(55),
            ['Osker']   = quest:event(55),
        },
    },
}

return quest
