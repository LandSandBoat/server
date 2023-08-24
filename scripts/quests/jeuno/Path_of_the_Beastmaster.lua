-----------------------------------
-- Path of the Beastmaster
-----------------------------------
-- Log ID: 3, Quest ID: 19
-- Brutus: !gotoid 17776652
-- Merchants Door !gotoid 17780840
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)

quest.reward =
{
    title = xi.title.ANIMAL_TRAINER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) and
            player:getMainLvl() >= 30
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(70)
                end,

            },
            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    player:unlockJob(xi.job.BST)
                    player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_BEASTMASTER)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
