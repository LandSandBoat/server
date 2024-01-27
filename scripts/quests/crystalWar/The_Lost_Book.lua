-----------------------------------
-- The Lost Book
-- !addquest 7 26
--
-- MYTHRIL_BEASTCOIN - !additem 749
-- VELLUM            - !additem 2550
--
-- Rhinostery Door South - !pos -1 -4.00 -198 94
-- Quu Bokye             - !pos -159 16 181 145
-- Optistery Door        - !pos -57 -5.0 89 94
-- qm0                   - !pos -141 1 -9 99
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_LOST_BOOK)

quest.reward =
{
    item = xi.item.SCROLL_OF_RETRACE,
}

quest.sections =
{
    -- Examine the right Rhinostery door (J-9 of the second map) for a cutscene.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getMainLvl() >= 30 and
                player:hasKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE)
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Rhinostery_South'] = quest:progressEvent(143),

            onEventFinish =
            {
                [143] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Bring a Mythril Beastcoin and travel to present-day Giddeus and trade Quu Bokye
    -- a Mythril Beastcoin to obtain a Leather-bound Book.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Rhinostery_South'] = quest:progressEvent(148), -- Optional dialogue
        },

        [xi.zone.GIDDEUS] =
        {
            ['Quu_Bokye'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.MYTHRIL_BEASTCOIN) then
                        return quest:progressEvent(65)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(64)
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.LEATHER_BOUND_BOOK)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Return to the Rhinostery in Windurst (S), and click the southern door for another cutscene.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Rhinostery_South'] = quest:progressEvent(144),

            onEventFinish =
            {
                [144] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Go to the Optistery (F-8 on the first map) of Windurst (S) and examine the door for a cutscene.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Optistery']        = quest:progressEvent(145),
            ['Door_Rhinostery_South'] = quest:event(150), -- Optional dialogue

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LEATHER_BOUND_BOOK)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    -- Head to Castle Oztroja (S) and examine the ??? at (G-8) on the first map.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4 and
                not player:hasKeyItem(xi.ki.LYNX_PELT)
        end,

        [xi.zone.CASTLE_OZTROJA_S] =
        {
            ['_qm0'] =
            {
                onTrigger = function(player, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LYNX_PELT)
                end,
            },
        },
    },

    -- Trade a sheet of Vellum to the Optistery door in Windurst Waters (S).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4 and
                player:hasKeyItem(xi.ki.LYNX_PELT)
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Optistery'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SHEET_OF_VELLUM) then
                        return quest:progressEvent(146)
                    end
                end,
            },

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.LYNX_PELT)
                    quest:setVar(player, 'Prog', 5)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },
    },

    -- Waited game day
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 5 and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay()
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Door_Optistery'] = quest:progressEvent(147),

            onEventFinish =
            {
                [147] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
