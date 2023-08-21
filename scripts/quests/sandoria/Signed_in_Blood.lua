-----------------------------------
-- Signed in  Blood
-- Sobane !pos -190 -3 97 230
-- CATHEDRAL_TAPESTRY !additem 1662
-- Abelard !pos -52 -11 -13 248
-- TORN_OUT_PAGES !addkeyitem 626
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SIGNED_IN_BLOOD)

quest.reward =
{
    item = xi.item.CUNNING_EARRING,
    gil  = 3500,
}

quest.sections =
{
    -- Talk to Sobane, she is willing to give you a quest, but she needs to be able to trust that you'll keep your mouth shut.
    -- She wants you to retrieve a Cathedral Tapestry.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(732, 0, xi.item.CATHEDRAL_TAPESTRY)
                end,
            },

            onEventFinish =
            {
                [732] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Trade the tapestry to Sobane and she'll explain the next step.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(733, 0, xi.item.CATHEDRAL_TAPESTRY)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.CATHEDRAL_TAPESTRY) then
                        return quest:progressEvent(734, 0, xi.item.CATHEDRAL_TAPESTRY)
                    end
                end,
            },

            onEventFinish =
            {
                [734] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:confirmTrade()
                end,
            },
        },
    },

    -- Travel to Selbina. Talk to Abelard, and he'll mention a diary he found, with missing pages.
    -- Perhaps his lips will loosen if you help him find them.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(735)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(1104)
                end,
            },

            onEventFinish =
            {
                [1104] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Travel to Ordelle's Caves and hunt for an Ordelle Chest Key. Once you find a key, look for a Treasure Chest and open it.
    -- Only people who have this quest flagged will receive some Torn-Out Pages (key item).
    -- NOTE: this step is not included in this quest LUA. The key item is obtained via code in scripts/globals/treasure.lua

    -- Return to Selbina and talk to the mayor. He'll reveal some information to you which will prove interesting to Sobane.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(735)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TORN_OUT_PAGES) then
                        return quest:progressEvent(1106)
                    else
                        return quest:event(1105)
                    end
                end,
            },

            onEventFinish =
            {
                [1106] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Return to Sobane to complete this quest and to receive your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(48)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(736)
                end,
            },

            onEventFinish =
            {
                [736] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TORN_OUT_PAGES)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- If you just completed Signed in Blood, you must zone out and back into Southern San d'Oria to flag Tea with a Tonberry
    -- Otherwise you get this event.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:needToZone()
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(737)
                end,
            },
        },
    },
}

return quest
