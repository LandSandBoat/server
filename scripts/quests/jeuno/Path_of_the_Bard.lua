-----------------------------------
-- Path of the Bard
-----------------------------------
-- Log ID: 3, Quest ID: 20
-- Bki Tbujhja : !pos -22 0 -60 245
-- Song Runes  : !pos -721 -7 102 103
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local valkurmID = require('scripts/zones/Valkurm_Dunes/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 3000,
    keyItem  = xi.ki.JOB_GESTURE_BARD,
    title    = xi.title.WANDERING_MINSTREL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(182),

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
                    player:unlockJob(xi.job.BRD)
                    player:messageSpecial(valkurmID.text.UNLOCK_BARD)

                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(180):replaceDefault(),
            ['Mertaire']    = quest:event(103):replaceDefault(),
        },
    },
}

return quest
