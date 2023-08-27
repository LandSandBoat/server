-----------------------------------
-- A Minstrel in Despair
-----------------------------------
-- Log ID: 3, Quest ID: 12
-- Mertaire : !pos -17 0 -61 245
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 1200,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT) == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrade = function(player, npc, trade)
                    print("triggered")
                    if npcUtil.tradeHasExactly(trade, { xi.items.POETIC_PARCHMENT }) then
                        return quest:progressEvent(101)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            }
        },
    },
}

return quest
