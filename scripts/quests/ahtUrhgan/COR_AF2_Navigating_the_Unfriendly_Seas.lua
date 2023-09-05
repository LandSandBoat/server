-----------------------------------
-- Navigating the Unfriendly Seas
-- qm6 (H-10/Boat)  : !pos 468.767 -12.292 111.817 54
-- Leypoint : !pos -200.027 -8.500 80.058 51
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------
local wajaomID = require("scripts/zones/Wajaom_Woodlands/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)

quest.reward =
{
    item  = xi.items.CORSAIRS_CULOTTES,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainJob() == xi.job.COR and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] = quest:progressEvent(232),

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
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

        [xi.zone.NASHMAU] =
        {
            ['Leleroon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.HYDROGAUGE) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(283)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(292)
                    end
                end,
            },

            onEventFinish =
            {
                [283] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Leypoint'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.HYDROGAUGE) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 2)
                        quest:setVar(player, 'leypointTimer', getMidnight())
                        return quest:messageSpecial(wajaomID.text.PLACE_HYDROGAUGE, xi.items.HYDROGAUGE)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'leypointTimer') <= os.time() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(508)
                    elseif
                        quest:getVar(player, 'leypointTimer') >= os.time() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:messageSpecial(wajaomID.text.ENIGMATIC_LIGHT, xi.items.HYDROGAUGE)
                    else
                        return quest:messageSpecial(wajaomID.text.LEYPOINT)
                    end
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'leypointTimer', 0)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(233)
                    end
                end,
            },

            onEventFinish =
            {
                [233] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
