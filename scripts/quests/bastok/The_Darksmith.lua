-----------------------------------
-- The Darksmith
-----------------------------------
-- Log ID: 1, Quest ID: 40
-- Mighty Fist : !pos -47 2 -30 237
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DARKSMITH)

quest.reward =
{
    fame     = 5,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 8000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Mighty_Fist'] = quest:progressEvent(565),

            onEventFinish =
            {
                [565] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.METALWORKS] =
        {
            ['Mighty_Fist'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.CHUNK_OF_DARKSTEEL_ORE, 2 } }) then
                        return quest:progressEvent(566)
                    end
                end,
            },

            onEventFinish =
            {
                [566] = function(player, csid, option, npc)
                    player:confirmTrade()

                    -- From previous implementation, award 30 fame (25 + 5) on first completion,
                    -- and 5 fame for any subsequent trade.
                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED then
                        player:addFame(xi.quest.fame_area.BASTOK, 25)
                    end

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
