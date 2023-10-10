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
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local northernSandoriaID = require("scripts/zones/Northern_San_dOria/IDs")
local ghelsbaID = require("scripts/zones/Ghelsba_Outpost/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.HEIR_TO_THE_HOLY_CREST,
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

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
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
                        not player:hasItem(xi.items.WYVERN_EGG)
                    then
                        if npcUtil.tradeHasExactly(trade, xi.items.PICKAXE) then
                            local chance = math.random(1, 5)
                            if chance <= 2 then
                                npcUtil.giveItem(player, xi.items.WYVERN_EGG)
                                player:tradeComplete(false)
                                player:startEvent(60, 1159, 0, 0, xi.items.WYVERN_EGG)-- successful no break
                                return quest:noAction()
                            elseif chance == 3 then
                                npcUtil.giveItem(player, xi.items.WYVERN_EGG)
                                player:confirmTrade()
                                player:startEvent(60, 1159, 1, 0, xi.items.WYVERN_EGG) -- successful but breaks
                                return quest:noAction()
                            elseif chance == 4 then
                                player:confirmTrade()
                                player:startEvent(60, 0, 1, 0) -- unsuccessful and breaks
                                return quest:noAction()
                            elseif chance == 5 then
                                player:tradeComplete(false)
                                player:startEvent(60, 0, 0, 0) -- unsuccessful and no break
                                return quest:noAction()
                            end
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
                        not player:hasItem(xi.items.WYVERN_EGG)
                    then
                        return quest:message(northernSandoriaID.text.DEEP_IN_MAZE)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        player:hasItem(xi.items.WYVERN_EGG)
                    then
                        return quest:progressEvent(62)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:message(northernSandoriaID.text.NEVER_HEARD_DOC)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if option == 0 then
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
                        return quest:progressEvent(33)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:confirmTrade()
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

        [xi.zone.GHELSBA_OUTPOST] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 33 and
                        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        player:delKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                        player:unlockJob(xi.job.DRG)
                        player:messageSpecial(ghelsbaID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
                        player:setPetName(xi.pet.type.WYVERN, option + 1)
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
