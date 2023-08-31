-----------------------------------
-- Light in the Darkness
-- !addquest 7 19
-- Gentle Tiger   : !pos -203.932 -9.998 2.237 87
-- Pagdako        : !pos -202.080 -6.000 -93.928 87
-- Blatherix      : !pos -309.824 -11.999 -42.791 87
-- Engelhart      : !pos -80.085 -4.425 -125.327 87
-- MINE_SHAFT_KEY : !addkeyitem 961
-- Corroded Door  : !pos -385.602 21.970 456.359 90
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS)

quest.reward =
{
    item = xi.item.ADAMAN_INGOT,
}

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
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),

            ['Pagdako'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(19)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Talk to Blatherix at (F-8)
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(21)
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- He asks you to bring him 30 chunks of Goblin Chocolate or 5000 gil to talk.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(22)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.CHUNK_OF_GOBLIN_CHOCOLATE, 30 } }) or
                        npcUtil.tradeHasExactly(trade, { { 'gil', 5000 } })
                    then
                        return quest:progressEvent(23)
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MINE_SHAFT_KEY)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Enter Pashhow Marshlands (S) from Grauberg (S) for a cutscene
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.PASHHOW_MARSHLANDS_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.GRAUBERG_S then
                        return 901
                    end
                end,
            },

            onEventFinish =
            {
                [901] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),
            ['Blatherix'] = quest:event(24),
        },
    },

    -- Check the Corroded Door at (F-5) in Pashhow Marshlands (S) to enter the battlefield for Light in the Darkness
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4
        end,

        -- Instance entry handled in instance script

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),
            ['Blatherix'] = quest:event(24),
        },
    },

    -- Enter Pashhow Marshlands (S) the instance for a cutscene
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.PASHHOW_MARSHLANDS_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 902
                end,
            },

            onEventFinish =
            {
                [902] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },
    },

    -- Once you have beaten the Quadav in Ruhotz Silvermines, talk to Gentle Tiger for the final cutscene
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 6
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),
            ['Blatherix'] = quest:event(24),

            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(27)
                end,
            },

            -- TODO: Before new day for next quest: cs 28

            onEventFinish =
            {
                [27] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- Upon failure, a new key is needed. Blatherix will ask for 10 chunks of Goblin Chocolate or 1000 gil to give you one
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 7
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- Reminders
            ['Gentle_Tiger'] = quest:event(17),
            ['Engelhart'] = quest:event(18),
            ['Pagdako'] = quest:event(20),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(25)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.CHUNK_OF_GOBLIN_CHOCOLATE, 10 } }) or
                        npcUtil.tradeHasExactly(trade, { { 'gil', 1000 } })
                    then
                        return quest:progressEvent(23)
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MINE_SHAFT_KEY)
                end,
            },
        },
    },
}

return quest
