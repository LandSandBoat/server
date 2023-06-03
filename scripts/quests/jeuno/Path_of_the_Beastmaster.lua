-----------------------------------
-- Path of the Beastmaster
-----------------------------------
-- Log ID: 3, Quest ID: 19
-- Brutus : !pos -55 8 95 244
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local upperJeunoID = require('scripts/zones/Upper_Jeuno/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem  = xi.ki.JOB_GESTURE_BEASTMASTER,
    title    = xi.title.ANIMAL_TRAINER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] = quest:progressEvent(70),

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    player:unlockJob(xi.job.BST)
                    player:messageSpecial(upperJeunoID.text.YOU_CAN_NOW_BECOME_A_BEASTMASTER)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus']  = quest:event(20),
            ['Chocobo'] = quest:event(72):replaceDefault(),
            ['Osker']   = quest:event(45):replaceDefault(),
        },
    },
}

return quest
