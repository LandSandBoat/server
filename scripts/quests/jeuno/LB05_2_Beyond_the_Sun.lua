-----------------------------------
-- Beyond the Sun
-----------------------------------
-- Log ID: 3, Quest ID: 76
-- Maat : !pos 8 3 118 243
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_SUN)
-----------------------------------

quest.reward =
{
    item  = {xi.items.MAATS_CAP},
    title = xi.title.ULTIMATE_CHAMPION_OF_THE_WORLD,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE and
                player:getMainJob() <= 15 and
                player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) == QUEST_COMPLETED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if utils.mask.isFull(player:getCharVar("maatsCap"), 15) then -- Defeated maat on 15 jobs
                        return quest:progressEvent(74)
                    end
                end,
            },

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() > 0 then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
