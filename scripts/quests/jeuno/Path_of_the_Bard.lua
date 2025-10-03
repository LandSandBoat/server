-----------------------------------
-- Path of the Bard
-----------------------------------
-- Log ID: 3, Quest ID: 20
-- Song Runes !pos -721 -7 102 103
-----------------------------------
local valkrumID    = zones[xi.zone.VALKURM_DUNES]
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    gil      = 3000,
    keyItem  = xi.ki.JOB_GESTURE_BARD,
    title    = xi.title.WANDERING_MINSTREL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == xi.questStatus.QUEST_COMPLETED
        end,

        -- It was found that all of the dialogue is optional and the player can go straight to the song runes in Valkrum Dunes upon finishing A Minstrel in Despair
        [xi.zone.LOWER_JEUNO] =
        {

            ['Bki_Tbujhja'] = quest:event(182),

            ['Mataligeat'] = quest:event(144),

            ['Mertaire'] = quest:messageName(lowerJeunoID.text.COULD_HE_BE, 0, 0, 0, 0, true, false),

        },

        [xi.zone.VALKURM_DUNES] =
        {
            ['Song_Runes'] = quest:progressCutscene(2),

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:unlockJob(xi.job.BRD)
                    player:messageSpecial(valkrumID.text.UNLOCK_BARD)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(180),

            ['Mataligeat'] = quest:event(143),

            ['Mertaire'] = quest:event(103),
        },
    },
}

return quest
