-----------------------------------
-- Message on the Wind
-- !addquest 7 1
--
-- Romualdo     - !pos 133 -19 -36 237
-- Romualdo (S) - !pos 54 -14 141 84
-- Childerich   - !pos -313 16 -515 89
-- qm3          - !pos 439 -40 79 89
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.MESSAGE_ON_THE_WINDS)

quest.reward =
{
    item = xi.item.SMART_GRENADE,
}

quest.sections =
{
    -- Section: Talk to Romualdo at the Cannonry in the Metalworks (second floor, K-9).
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 20
        end,

        [xi.zone.METALWORKS] =
        {
            ['Romualdo'] = quest:progressEvent(952),

            onEventFinish =
            {
                [952] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1) -- Quest doesn't appear in log yet
                end,
            },
        },
    },

    -- Section: Travel to the past and speak to him again, this time in Batallia Downs (S) (I-7).
    {
        check = function(player, status, vars)
            return vars.Prog == 1
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] = quest:progressEvent(109),

            onEventFinish =
            {
                [109] = function(player, csid, option, npc)
                    quest:begin(player) -- Quest now appears in log
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Speak with Childerich in Grauberg (S) at the west side of the house at (E-12).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] = quest:progressEvent(110), -- Optional dialogue
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] = quest:progressEvent(1),

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
            ['Childerich'] = quest:progressEvent(2), -- Optional dialogue

            ['qm3'] = quest:progressEvent(3),

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
            ['Childerich'] = quest:progressEvent(4),

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
            ['Childerich'] = quest:progressEvent(5),
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Romualdo'] = quest:progressEvent(111),

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'PostCS', 1)
                    end
                end,
            },
        },
    },

    -- Section: Post quest cutscene with Romualdo
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and quest:getVar(player, 'PostCS') == 1
        end,

        [xi.zone.METALWORKS] =
        {
            ['Romualdo'] = quest:progressEvent(953),

            onEventFinish =
            {
                [953] = function(player, csid, option, npc)
                    quest:setVar(player, 'PostCS', 2)
                end,
            },
        },
    },

    -- Post quest cutscene with Childerich
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and quest:getVar(player, 'PostCS') == 2
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] = quest:progressEvent(6),

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'PostCS', 0)
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
            ['Romualdo'] = quest:event(112):replaceDefault(),
        },
    },

    -- New default text for Childerich
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:hasTitle(xi.title.WINDTALKER)
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Childerich'] = quest:event(7):replaceDefault(),
        },
    },
}

return quest
