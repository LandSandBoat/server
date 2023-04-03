-----------------------------------
-- The Holy Crest
-- !addquest 0 93
-----------------------------------
-- Ceraulian !gotoid 17727560
-- Arminibit !gotoid 17727559
-- Novalmauge !gotoid 17461510
-- Morjean !gotoid 17723419
-- Excavation Point #1 !gotoid 17588776
-- QM1 MERIPHATAUD_MOUNTAINS !gotoid 17265243
-- Rahal: !gotoid 17731592
-- Hut Door: !gotoid 17350950
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)

quest.reward =
{
    item     = xi.items. DRACHEN_ARMET,
    fame     = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 30
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Arminibit'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(24)
                end,
            },

            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(24)
                end,
            },
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(6)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(7)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(65)
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Excavation_Point'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 3 and -- allows players who drop it to get another one...
                        not player:hasItem(xi.items.WYVERN_EGG) and
                        npcUtil.tradeHasExactly(trade, xi.items.PICKAXE)
                    then
                        if npcUtil.giveItem(player, xi.items.WYVERN_EGG) then
                            player:confirmTrade()
                            return quest:noAction()
                        end
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        player:hasItem(xi.items.WYVERN_EGG) or
                        quest:getVar(player, 'Prog') == 4
                    then
                        return quest:progressEvent(62)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.MERIPHATAUD_MOUNTAINS] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.WYVERN_EGG) and
                        quest:getVar(player, 'Prog') == 4
                    then
                        return quest:progressEvent(56)
                    end
                end,
            },

            onEventFinish =
            {
                [56] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:confirmTrade()
                    return quest:event(33)
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 5 and
                        not player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        return quest:progressEvent(60)
                    elseif
                        quest:getVar(player, 'Prog') == 5 and
                        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        return quest:event(122)
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DRAGON_CURSE_REMEDY)
                end,
            },
        },
    },
}

return quest
