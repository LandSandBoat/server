-----------------------------------
-- Father Figure
-----------------------------------
-- Log ID: 1, Quest ID: 29
-- Michea : !pos -298 -16 -157 235
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FATHER_FIGURE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 2200,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELVAAN_GOLDSMITH) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2 and
                not player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.DISTANT_LOYALTIES) ~= QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] = quest:progressEvent(240),

            onEventFinish =
            {
                [240] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SILVER_INGOT) then
                        return quest:progressEvent(241)
                    end
                end,
            },

            onEventFinish =
            {
                [241] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
