-- -----------------------------------
-- -- Path of the Bard
-- -----------------------------------
-- -- Log ID: 3, Quest ID: 20
-- -- Song Runes: !pos -717.633 -7.574 102.987 103
-- -----------------------------------
local valkurmID = zones[xi.zone.VALKURM_DUNES]
local jeunoID   = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD)

quest.reward =
{
    gil      = 3000,
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    title    = xi.title.WANDERING_MINSTREL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(182),
            ['Mertaire']    = quest:messageSpecial(jeunoID.text.COULD_HE_BE):importantOnce()
        },

        [xi.zone.VALKURM_DUNES] =
        {
            ['Song_Runes'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.BRD)
                        player:messageSpecial(valkurmID.text.UNLOCK_BARD)
                    end
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
            ['Mataligeat'] = quest:event(143),
            ['Bki_Tbujhja'] = quest:event(180),
        },
    }
}

return quest
