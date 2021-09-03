-----------------------------------
-- Light in the Darkness
-- !addquest 7 19
-- Gentle Tiger   : !pos -203.932 -9.998 2.237 87
-- Pagdako        : !pos -202.080 -6.000 -93.928 87
-- Blatherix      : !pos -309.824 -11.999 -42.791 87
-- MINE_SHAFT_KEY : !addkeyitem 961
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS)

quest.sections =
{
    -- Talk to Gentle Tiger at (H-6)
    -- TODO: 1 day wait after WOTG Mission: Cait Sith
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                   player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.CAIT_SITH
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(16)
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Talk to Pagdako at (H-9)
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminder
            ['Gentle_Tiger'] = quest:event(17),

            -- cs 18: Engelhart talking about the assassination

            ['Pagdako'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(19)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Talk to Blatherix at (F-8)
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Pagdako'] = quest:event(20),
            -- cs 18: Engelhart talking about the assassination

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(21)
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Talk to Blatherix at (F-8)
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Pagdako'] = quest:event(20),
            ['Blatherix'] = quest:event(22),
            -- cs 18: Engelhart talking about the assassination

            -- cs 23: Blatherix onTrade -> Mine Shaft Key
        },
    },

    -- Enter Pashhow Marshlands (S) from Grauberg (S) for a cutscene
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Pagdako'] = quest:event(20),
            ['Blatherix'] = quest:event(24),
            -- cs 18: Engelhart talking about the assassination
        },
    },

    -- Check the Corroded Door at (F-5) in Pashhow Marshlands (S) to enter the battlefield for Light in the Darkness
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Wyatt'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Upon failure, a new key is needed. Blatherix will ask for 10 chunks of Goblin Chocolate or 1000 gil to give you one
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            -- cs: 25
            -- Blatherix: You need another key?
        },
    },

    -- Once you have beaten the Quadav in Ruhotz Silvermines, talk to Gentle Tiger for the final cutscene
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            -- Gentle Tiger: cs 27

            -- Before new day for next quest: cs 28
        },
    },
}

return quest
