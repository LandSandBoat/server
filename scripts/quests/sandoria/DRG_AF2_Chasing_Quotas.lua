-----------------------------------
-- Chasing Quotas
-- !addquest 0 95
-----------------------------------
-- Ceraulian !gotoid 17727560
-- Arminibit !gotoid 17727559
-- Miaux !gotoid 17723442
-- Ardea !gotoid 17739794
-- Esca !gotoid 17187493
-- Batallia Downs ??? (qm2) !gotoid 17207822

-- For current, timer is 60 seconds
-- line 126  quest:setVar(player, 'Timer', os.time() + 60)
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local batalliaID = require("scripts/zones/Batallia_Downs/IDs")
local westRonfaureID = require("scripts/zones/West_Ronfaure/IDs")
local portSandyID = require('scripts/zones/Port_San_dOria/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS)

quest.reward =
{
    item     = xi.items. DRACHEN_BRAIS,
    fame     = 40,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DRG and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMAN_S_WORK) == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Arminibit'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csSeen') == 0 then
                        return quest:progressEvent(18)
                    elseif quest:getVar(player, 'csSeen') == 1 then --Declined First Offering.
                        return quest:progressEvent(14)
                    end
                end,
            },

            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csSeen') == 0 then
                        return quest:progressEvent(18)
                    elseif quest:getVar(player, 'csSeen') == 1 then --Declined First Offering.
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'csSeen', 0)
                    else
                        quest:setVar(player, 'csSeen', 1) -- Declined First Offering.
                    end
                end,

                [18] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'csSeen', 0)
                    else
                        quest:setVar(player, 'csSeen', 1)
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

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        if quest:getVar(player, 'Timer') > os.time() then
                            return quest:event(3)
                        else
                            return quest:progressEvent(7)
                        end
                    elseif questProgress == 2 then
                        return quest:event(8)
                    elseif questProgress == 3 then
                        return quest:event(6)
                    elseif questProgress == 4 or questProgress == 5 then
                        return quest:event(9)
                    elseif questProgress == 6 then
                        return quest:progressEvent(15)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.GOLD_HAIRPIN) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        player:tradeComplete()
                        quest:setVar(player, 'Timer', getMidnight())
                        return quest:progressEvent(17)
                    end
                end,
            },

        onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Timer', 0)
                end,

                [15] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RANCHURIOMES_LEGACY)
                        player:messageSpecial(portSandyID.text.KEYITEM_LOST, xi.ki.RANCHURIOMES_LEGACY)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Miaux'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(67)
                    elseif questProgress == 3 or questProgress == 4 then
                        return quest:event(68)
                    elseif questProgress >= 5 then
                        return quest:event(66)
                    end
                end,
            },

            onEventFinish =
            {
                [67] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.SHINY_EARRING)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Ardea'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 3 then
                        return quest:progressEvent(264)
                    elseif questProgress == 4 then
                        return quest:event(265)
                    end
                end,
            },

            onEventFinish =
            {
                [264] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Esca'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 4 then
                        return quest:progressEvent(137)
                    elseif questProgress == 5 then
                        return quest:event(138)
                    end
                end,
            },

            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:delKeyItem(xi.ki.SHINY_EARRING)
                    player:messageSpecial(westRonfaureID.text.KEYITEM_LOST, xi.ki.SHINY_EARRING)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 5 and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        if npcUtil.popFromQM(player, npc, batalliaID.mob.STURMTIGER, { claim = true, hide = 0 }) then
                            player:messageSpecial(batalliaID.text.EVIL_PRESENSE)
                            return quest:noAction()
                        end
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.RANCHURIOMES_LEGACY)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 6)
                        return quest:noAction()
                    end
                end,
            },

            ['Sturmtiger'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 5 then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] = quest:event(16):replaceDefault(),
        },
    },
}

return quest
