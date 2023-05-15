-----------------------------------
-- Scooped!
-----------------------------------
-- !addquest 2 38
-- Hariga-Origa : !pos -70.244, -3.800, -4.439
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SCOOPED)

quest.reward =
{
    gil = 1500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES) and
                not player:needToZone()
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Naiko-Paneiko'] = quest:progressEvent(676),

            onEventFinish =
            {
                [676] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Naiko-Paneiko'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BRONZE_BOX) then
                        return quest:progressEvent(680)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(677)
                end,
            },

            onEventFinish =
            {
                [680] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
