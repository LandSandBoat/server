-----------------------------------
-- Honor Under Fire
-----------------------------------
-- !addquest 7 43
-- Gentle Tiger    : !pos -203.932 -9.998 2.237 87
-- ??? (qm8)       : !pos -356.278 -32.117 285.950 83
-- Beastman Ensign : !pos 241.000 -31.995 242.999 83
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.HONOR_UNDER_FIRE)

quest.reward =
{
    item = xi.item.ELIXIR_TANK,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.QUELLING_THE_STORM) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.CROSSROADS_OF_TIME
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(66),

            onEventFinish =
            {
                [66] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(67),
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['qm8'] = quest:progressEvent(114),

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(67),
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Beastman_Ensign'] = quest:progressEvent(115),

            onEventFinish =
            {
                [115] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(68),

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.FLARE_GRENADE) then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(69),
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Beastman_Ensign'] = quest:progressEvent(116),

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.FLARE_GRENADE) then
                        return quest:event(69)
                    else
                        return quest:progressEvent(70)
                    end
                end,
            },

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FLARE_GRENADE)
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                -- Honor Under Fire instance is not implemented currently.
                [10000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:setPos(241.000, -31.995, 242.999, 0, xi.zone.VUNKERL_INLET_S)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.VUNKERL_INLET_S] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.EVERBLOOM_HOLLOW then
                    return 117
                end
            end,

            onEventFinish =
            {
                [117] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 6
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(71),

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
