-----------------------------------
-- A Minstrel in Despair
-----------------------------------
-- Log ID: 3, Quest ID: 12
-- Mertaire : !pos -17 0 -61 245
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local lowerJeunoID = require('scripts/zones/Lower_Jeuno/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 2100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] = quest:event(182),

            ['Mertaire'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.POETIC_PARCHMENT) then
                        return quest:progressEvent(101)
                    end
                end,

                onTrigger = quest:messageText(lowerJeunoID.text.MERTAIRE_MALLIEBELL_LEFT),
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [182] = function(player, csid, option, npc)
                    -- NOTE: This Event is available prior to completing this quest, but remains the same
                    -- for Path of the Bard.

                    xi.quest.setVar(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:messageText(lowerJeunoID.text.MERTAIRE_HE_COULDNT_BE):replaceDefault(),
        },
    },
}

return quest
