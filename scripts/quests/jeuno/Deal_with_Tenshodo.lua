-----------------------------------
-- Deal with Tenshodo
-----------------------------------
-- Log ID: 3, Quest ID: 26
-- Garnev : !pos 30 4 -36 245
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DEAL_WITH_TENSHODO)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem  = xi.ki.CLOCK_TOWER_OIL,
    title    = xi.title.TRADER_OF_RENOWN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CLOCK_MOST_DELICATE) == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Garnev'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.quest.fame_area.NORG) >= 2 then
                        return quest:progressEvent(167)
                    else
                        return quest:event(168)
                    end
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Garnev'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.GOLD_ORCMASK) then
                        return quest:progressEvent(166)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
