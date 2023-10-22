-----------------------------------
-- Operation Teatime
-- PUP AF2
-----------------------------------
-- Log ID: 6, Quest ID: 28
-- Iruku-Waraki !pos 101.329 -6.999 -29.042 50
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME)

quest.reward =
{
    item  = xi.items.PUPPETRY_CHURIDARS,
}

quest.sections =
{
    -- Section: Quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PUP and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                player:getLocalVar('Quest[6][28]mustZone') == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] = quest:progressEvent(778),

            onEventFinish =
            {
                [778] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(779)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(781)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.items.FLASK_OF_SLEEPING_POTION, xi.items.CUP_OF_CHAI }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(780)
                    end
                end,
            },

            onEventFinish =
            {
                [780] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Dnegan'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'Wait') ~= VanadielDayOfTheYear()
                    then
                        return quest:progressEvent(290)
                    end
                end,
            },

            onEventFinish =
            {
                [290] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Wait', VanadielDayOfTheYear())
                    elseif option == 1 then
                        quest:setVar(player, 'Prog', 3)
                        quest:setVar(player, 'Wait', 0)
                    end
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm10'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(15)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
