-----------------------------------
-- Quelling the Storm
-----------------------------------
-- !addquest 7 42
-- Gentle Tiger            : !pos -203.932 -9.998 2.237 87
-- Paul                    : !pos -192.880 -3.999 53.083 87
-- Biggorf                 : !pos -210.139 1.999 -140.872 87
-- Wilhelmina              : !pos -158.092 -4.000 -120.077 87
-- Blatherix               : !pos -309.824 -11.999 -42.791 87
-- ??? (qm8)               : !pos -356.278 -32.117 285.950 83
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.QUELLING_THE_STORM)

local function checkTownNpcProgress(player)
    if
        quest:getVar(player, 'Paul') == 1 and
        quest:getVar(player, 'Biggorf') == 1 and
        quest:getVar(player, 'Wilhelmina') == 1
    then
        quest:setVar(player, 'Prog', 2)
    end
end

quest.reward =
{
    item = xi.item.GOBLIN_BELT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRE_IN_THE_HOLE) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.CROSSROADS_OF_TIME
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.NORTH_GUSTABERG_S then
                    return 179
                end
            end,

            onEventFinish =
            {
                [179] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(180)
                end,
            },

            onEventFinish =
            {
                [180] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(186),

            ['Paul'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Paul') == 0 then
                        return quest:progressEvent(193)
                    else
                        return quest:event(196)
                    end
                end,
            },

            ['Biggorf'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Biggorf') == 0 then
                        return quest:progressEvent(194)
                    else
                        return quest:event(197)
                    end
                end,
            },

            ['Wilhelmina'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Wilhelmina') == 0 then
                        return quest:progressEvent(192)
                    else
                        return quest:event(195)
                    end
                end,
            },

            onEventFinish =
            {
                [192] = function(player, csid, option, npc)
                    quest:setVar(player, 'Wilhelmina', 1)
                    checkTownNpcProgress(player)
                end,

                [193] = function(player, csid, option, npc)
                    quest:setVar(player, 'Paul', 1)
                    checkTownNpcProgress(player)
                end,

                [194] = function(player, csid, option, npc)
                    quest:setVar(player, 'Biggorf', 1)
                    checkTownNpcProgress(player)
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
            ['Paul']       = quest:event(196),
            ['Biggorf']    = quest:event(197),
            ['Wilhelmina'] = quest:event(195),

            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(181)
                end,
            },

            onEventFinish =
            {
                [181] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
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
            ['Gentle_Tiger'] = quest:event(187),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(182)
                end,
            },

            onEventFinish =
            {
                [182] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(187),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(188)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(
                            trade,
                            {
                                xi.item.GOBLIN_MESS_TIN,
                                xi.item.GOBLIN_MUSHPOT,
                                xi.item.PINCH_OF_TWINKLE_POWDER,
                            }
                        )
                    then
                        return quest:progressEvent(183)
                    end
                end,
            },

            onEventFinish =
            {
                [183] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Blatherix'] = quest:event(189),

            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(184)
                end,
            },

            onEventFinish =
            {
                [184] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 6
        end,

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(113)
                end,
            },

            onEventFinish =
            {
                [113] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(190),
            ['Blatherix']    = quest:event(189),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 7
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(191),

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(185)
                end,
            },

            onEventFinish =
            {
                [185] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
