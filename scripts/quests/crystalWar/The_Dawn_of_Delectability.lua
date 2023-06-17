-----------------------------------
-- The Dawn of Delectability
-- !addquest 7 5
--
-- BASTORE_SWEEPER - !additem 5473
-- PEPPERONI       - !additem 5660
-- WALNUT          - !additem 5661
-- DRAGON_FRUIT    - !additem 5662
--
-- Ranpi-Monpi (S) - !pos -115 -3 43 94
-- Ranpi-Monpi     - !pos -116 -3 52 238
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/items')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_DAWN_OF_DELECTABILITY)

quest.reward =
{
    item = xi.items.TRAINEE_KNIFE,
}

quest.sections =
{
    -- Visit Ranpi-Monpi (S) in Windurst Waters (S) (E-9, north side) to start the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(117),

            onEventFinish =
            {
                [117] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Speak with Ranpi in the present and he'll request ingredients
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(119), -- Optional dialogue
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(978),

            onEventFinish =
            {
                [978] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Trade Ranpi the ingredients
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.items.PEPPERONI, xi.items.WALNUT, xi.items.DRAGON_FRUIT, xi.items.BASTORE_SWEEPER })
                    then
                        return quest:progressEvent(983)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(979) -- reminder dialogue
                end,
            },

            onEventFinish =
            {
                [983] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, "Timer", VanadielUniqueDay() + 1)
                end,
            },
        },
    },

    -- Speak with Ranpi before day is up
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3 and
                quest:getVar(player, "Timer") > VanadielUniqueDay()
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(982)
        },
    },

    -- Speak with Ranpi after a game day wait
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3 and
                quest:getVar(player, "Timer") <= VanadielUniqueDay()
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(980),

            onEventFinish =
            {
                [980] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RANPI_MONPI_SPECIALTY)
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, "Timer", 0)
                end,
            },
        },
    },

    -- Return to Windurst Waters (S) and feed Ranpi.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(118),

            onEventFinish =
            {
                [118] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.RANPI_MONPI_SPECIALTY)
                    npcUtil.giveKeyItem(player, xi.ki.CULINARY_KNIFE)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },

    -- Return to Windurst Waters and finish the quest
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] = quest:progressEvent(981),

            onEventFinish =
            {
                [981] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CULINARY_KNIFE)
                    end
                end,
            },
        },
    },

    -- New default text for Ranpi
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED or vars.Prog == 5
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Ranpi-Monpi'] = quest:event(120):replaceDefault(),
        },
    },
}

return quest
