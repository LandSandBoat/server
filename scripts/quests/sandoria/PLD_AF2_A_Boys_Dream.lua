-----------------------------------
-- A Boys Dream
-- !addquest 0 91
-----------------------------------
-- Ailbeche: !gotoid 17723401
-- Exoroche: !gotoid 17719356
-- Fishing pool : !pos -89 22 -38 151
-- Odontotyrannus !spawnmob 17396141
-- Zaldon: !gotoid 17793047
-- Prince Trion Room !pos -38 -3 73 233
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require("scripts/globals/status")
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM)

quest.reward =
{
    item     = xi.items.GALLANT_LEGGINGS,
    fame     = 40,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PLD and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD) == QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(41) -- Starts Quest.
                    elseif quest:getVar(player, 'Prog') == 1 then --declined first
                        return quest:progressEvent(40)
                    end
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    else
                        quest:setVar(player, 'Prog', 1) -- Declined First offering.
                    end
                end,

                [40] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:event(46)
                    elseif questProgress == 3 then
                        return quest:event(39) -- During Quest "A Boy's Dream" (after exoroche cs)
                    elseif questProgress == 4 then
                        return quest:event(60) -- During Quest "A Boy's Dream" (after trading bug) madame ?
                    elseif questProgress == 5 then
                        return quest:messageSpecial(ID.text.AILBECHE_TRADE_FISH)
                    elseif questProgress == 6 then
                        return quest:progressEvent(25) -- During Quest "A Boy's Dream" (after Zaldon CS)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.GIANT_SHELL_BUG) and
                        questProgress == 3
                    then
                        return quest:progressEvent(15) -- During Quest "A Boy's Dream" (trading bug) madame ?
                    elseif
                        npcUtil.tradeHasExactly(trade, xi.items.ODONTOTYRANNUS) and
                        questProgress == 4
                    then
                        return quest:progressEvent(47) -- During Quest "A Boy's Dream" (trading odontotyrannus)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [25] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,

                [47] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },

        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Exoroche'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 2 and
                        player:getMainJob() == xi.job.PLD
                    then
                        return quest:progressEvent(50)
                    elseif questProgress == 7 then
                        return quest:progressEvent(32)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                end,

                [50] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 4 and
                        npcUtil.tradeHasExactly(trade, xi.items.ODONTOTYRANNUS)
                    then
                        return quest:progressEvent(85)
                    end
                end,
            },

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_BOOTS)
                    quest:setVar(player, 'Prog', 6)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 8 then
                        return quest:progressEvent(88)
                    end
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    if
                        player:getMainJob() == xi.job.PLD and
                        quest:complete(player)
                    then
                        player:delKeyItem(xi.ki.KNIGHTS_BOOTS)
                        return quest:event(90)
                    else
                        if quest:complete(player) then
                            player:delKeyItem(xi.ki.KNIGHTS_BOOTS)
                        end
                    end
                end,

                [90] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDER_OATH)
                    end
                end,
            },
        },
    },
}

return quest
