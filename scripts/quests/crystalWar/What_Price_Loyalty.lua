-----------------------------------
-- What Price Loyalty
-----------------------------------
-- !addquest 7 50
-- Gentle Tiger      : !pos -203.932 -9.998 2.237 87
-- Roderich          : !pos -400.039 40.004 -90.445 88
-- Forbidding Portal : !pos 320.000 -10.835 158.699 137
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.WHAT_PRICE_LOYALTY)

quest.reward =
{
    item = xi.item.FOURTH_STAFF,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BENEATH_THE_MASK) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.FATE_IN_HAZE
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(348),

            onEventFinish =
            {
                [348] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SACK_OF_VICTUALS)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0 and
                player:hasKeyItem(xi.ki.SACK_OF_VICTUALS)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(354),
        },

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Roderich'] = quest:progressEvent(10),

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:delKeyItem(xi.ki.SACK_OF_VICTUALS)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Roderich'] = quest:event(11),
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(349),

            onEventFinish =
            {
                [349] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(355),
        },

        [xi.zone.XARCABARD_S] =
        {
            onZoneIn = function(player, prevZone)
                return 8
            end,

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.COMMANDERS_ENDORSEMENT)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 3 and
                player:hasKeyItem(xi.ki.COMMANDERS_ENDORSEMENT)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(355),
        },

        [xi.zone.XARCABARD_S] =
        {
            ['Forbidding_Portal'] = quest:progressEvent(9),

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
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
                    if player:hasKeyItem(xi.ki.COMMANDERS_ENDORSEMENT) then
                        return quest:event(355)
                    else
                        return quest:progressEvent(357)
                    end
                end,
            },

            onEventFinish =
            {
                [357] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.COMMANDERS_ENDORSEMENT)
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                -- What Price Loyalty instance is not implemented currently.
                [10000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:setPos(320.000, -10.835, 158.699, 0, xi.zone.XARCABARD_S)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.XARCABARD_S] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.EVERBLOOM_HOLLOW then
                    return 10
                end
            end,

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:progressEvent(350),

            onEventFinish =
            {
                [350] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(356),
        },
    },
}

return quest
