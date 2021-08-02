-----------------------------------
-- Message on the Wind
-- !addquest 7 1
--
-- Romualdo - !pos 133 -19 -36 237
--
-- Romualdo (S) - !pos 54 -14 141 84
--
-- Childerich - !pos -313 16 -515 89
-- qm3 - !pos 439 -40 79 89
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/items')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.MESSAGE_ON_THE_WINDS)

quest.reward =
{
    item = xi.items.SMART_GRENADE,
}

quest.sections =
{
    -- Talk to Romualdo at the Cannonry in the Metalworks (second floor, K-9).
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getMainLvl() >= 20
        end,

        [xi.zone.METALWORKS] =
        {
            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(952)
                end,
            },

            onEventFinish =
            {
                [952] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1) -- Quest doesn't appear in log yet
                end,
            },
        },
    },

    -- Travel to the past and speak to him again, this time in Batallia Downs (S) (I-7).
    {
        check = function(player, status, vars)
            return vars.Prog == 1
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(109)
                end,
            },

            onEventFinish =
            {
                [109] = function(player, csid, option, npc)
                    quest:begin(player) -- Quest now appears in log
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Speak with Childerich in Grauberg (S) at the west side of the house at (E-12).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(110) -- Optional dialogue
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(1)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Check the ??? at J-9.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(2) -- Optional dialogue
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(3)
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    -- Speak with Childerich.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(4)
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },

    -- New default text for Childerich
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(5)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(111)
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:setCharVar("WindsPostCS", 1)
                end,
            },
        },
    },

    -- Post quest cutscene with Romualdo
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getCharVar("WindsPostCS") == 1
        end,

        [xi.zone.METALWORKS] =
        {
           ['Romualdo'] =
           {
                onTrigger = function(player, npc)
                    return quest:progressEvent(953)
                end,
            },

            onEventFinish =
            {
                [953] = function(player, csid, option, npc)
                    player:setCharVar("WindsPostCS", 2)
                end,
            },
        },
    },

    -- Post quest cutscene with Childerich
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getCharVar("WindsPostCS") == 2
        end,

        [xi.zone.GRAUBERG_S] =
        {
           ['Childerich'] =
           {
                onTrigger = function(player, npc)
                    return quest:progressEvent(6)
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    player:setCharVar("WindsPostCS", 0)
                    player:addTitle(xi.title.WINDTALKER)
                end,
            },
        },
    },

    -- New default text for Romualdo (S)
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(112):replaceDefault()
                end,
            },
        },
    },

    -- New default text for Childerich
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:hasTitle(xi.title.Windtalker)
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(7):replaceDefault()
                end,
            },
        },
    },
}

return quest
