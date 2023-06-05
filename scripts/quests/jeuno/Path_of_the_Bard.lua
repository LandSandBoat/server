-----------------------------------
-- Path of the Bard
-----------------------------------
-- Log ID: 3, Quest ID: 20
-- Mertaire          : !gotoid 17780764
-- Mataligeat        : !gotoid 17780765
-- Bki Tbujhja       : !gotoid 17780766
-- Song Runes (Dunes): !gotoid 17199695
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 3000,
    title    = xi.title.WANDERING_MINSTREL,
}
quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Optional') == 0 then
                        quest:setVar(player, 'Optional', 1)
                        return quest:event(141)
                    end
                end,
            },

            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Optional') == 1 then
                        quest:setVar(player, 'Optional', 0)
                        return quest:event(141)
                    end
                end,
            },

            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(182)
                    end
                end,
            },

            onEventFinish =
            {
                [182] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.VALKURM_DUNES] =
        {
            ['Song_Runes'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.BRD) -- Bard
                        player:messageSpecial(ID.text.UNLOCK_BARD)
                    end
                end,
            },
        },
    },
}

return quest
