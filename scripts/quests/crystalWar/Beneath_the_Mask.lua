-----------------------------------
-- Beneath the Mask
-----------------------------------
-- !addquest 7 49
-- Gentle Tiger: !pos -203.932 -9.998 2.237 87
-- Red Axe     : !pos 304.627 -27.500 13.955 175
-- Leadavox    : !pos 207.081 -31.997 315.458 83
-- Hoarfang    : !pos -263.577 -40.757 -329.347 136
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BENEATH_THE_MASK)

quest.reward =
{
    item = xi.item.SUPER_RERAISER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.HONOR_UNDER_FIRE) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.FATE_IN_HAZE
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(345),

            onEventFinish =
            {
                [345] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(351),
        },

        [xi.zone.BEADEAUX_S] =
        {
            onZoneIn = function(player, prevZone)
                return 1
            end,

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:progressEvent(346),

            onEventFinish =
            {
                [346] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(352),
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Red_Axe'] = quest:progressEvent(42),

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
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
            ['Gentle_Tiger'] = quest:event(352),
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Red_Axe'] = quest:event(44),
        },

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Leadavox'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.LUMP_OF_BEESWAX, xi.item.JAR_OF_RED_TEXTILE_DYE }) then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:confirmTrade()

                    if npcUtil.giveKeyItem(player, xi.ki.WAX_SEAL) then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 4 and
                player:hasKeyItem(xi.ki.WAX_SEAL)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(352),
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Red_Axe'] = quest:progressEvent(43),

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:delKeyItem(xi.ki.WAX_SEAL)
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
            ['Gentle_Tiger'] = quest:progressEvent(347),

            onEventFinish =
            {
                [347] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Red_Axe'] = quest:event(45),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 6
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(353),
        },

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Hoarfang'] = quest:progressEvent(7),

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
